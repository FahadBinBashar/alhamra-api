<?php

namespace App\Http\Controllers;

use App\Http\Resources\AgentSettlementResource;
use App\Models\AgentSettlement;
use App\Models\User;
use App\Services\AgentSettlementService;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\Rule;
use InvalidArgumentException;

class AgentSettlementController extends Controller
{
    public function __construct(private AgentSettlementService $settlementService)
    {
    }

    public function myPending(Request $request)
    {
        $user = $request->user();
        $agentId = $user?->agent?->id;

        if (! $agentId) {
            abort(422, 'Only agent users can access settlement data.');
        }

        $pendingAmount = $this->settlementService->availableAmount($agentId);

        return response()->json([
            'data' => [
                'agent_id' => $agentId,
                'pending_settlement_amount' => $pendingAmount,
            ],
        ]);
    }

    public function store(Request $request): AgentSettlementResource
    {
        $user = $request->user();
        $agentId = $user?->agent?->id;

        if (! $agentId) {
            abort(422, 'Only agent users can submit settlement requests.');
        }

        $data = $request->validate([
            'amount' => ['required', 'numeric', 'min:0.01'],
            'payment_method' => ['required', Rule::in([
                AgentSettlement::PAYMENT_METHOD_CASH,
                AgentSettlement::PAYMENT_METHOD_BANK,
                AgentSettlement::PAYMENT_METHOD_CHECK,
            ])],
            'reference_no' => ['nullable', 'string', 'max:255'],
            'attachment' => ['required', 'file', 'mimes:jpg,jpeg,png,pdf,webp', 'max:10240'],
            'note' => ['nullable', 'string'],
        ]);

        /** @var UploadedFile $attachment */
        $attachment = $data['attachment'];
        $attachmentPath = $attachment->store('agent-settlements/slips', config('filesystems.default'));

        $settlement = DB::transaction(function () use ($agentId, $data, $attachmentPath) {
            $availableAmount = $this->settlementService->availableAmount($agentId);

            if ((float) $data['amount'] > $availableAmount) {
                abort(422, 'Requested settlement amount exceeds pending balance.');
            }

            return AgentSettlement::create([
                'agent_id' => $agentId,
                'amount' => $data['amount'],
                'payment_method' => $data['payment_method'],
                'reference_no' => $data['reference_no'] ?? null,
                'attachment_url' => $attachmentPath,
                'note' => $data['note'] ?? null,
                'status' => AgentSettlement::STATUS_PENDING,
            ]);
        });

        return new AgentSettlementResource($settlement->load(['agent.user']));
    }

    public function myRequests(Request $request): AnonymousResourceCollection
    {
        $user = $request->user();
        $agentId = $user?->agent?->id;

        if (! $agentId) {
            abort(422, 'Only agent users can view settlement requests.');
        }

        $settlements = AgentSettlement::query()
            ->with(['agent.user', 'approver'])
            ->where('agent_id', $agentId)
            ->orderByDesc('created_at')
            ->paginate($request->integer('per_page', 15))
            ->appends($request->query());

        return AgentSettlementResource::collection($settlements);
    }

    public function index(Request $request): AnonymousResourceCollection
    {
        $this->ensureAdminUser($request);

        $data = $request->validate([
            'status' => ['nullable', Rule::in([
                AgentSettlement::STATUS_PENDING,
                AgentSettlement::STATUS_APPROVED,
                AgentSettlement::STATUS_REJECTED,
            ])],
        ]);

        $query = AgentSettlement::query()
            ->with(['agent.user', 'approver'])
            ->orderByDesc('created_at');

        if (! empty($data['status'])) {
            $query->where('status', $data['status']);
        }

        $settlements = $query
            ->paginate($request->integer('per_page', 15))
            ->appends($request->query());

        return AgentSettlementResource::collection($settlements);
    }

    public function approve(AgentSettlement $agentSettlement, Request $request): AgentSettlementResource
    {
        $this->ensureAdminUser($request);

        try {
            $this->settlementService->approve($agentSettlement, $request->user());
        } catch (InvalidArgumentException $exception) {
            abort(422, $exception->getMessage());
        }

        return new AgentSettlementResource($agentSettlement->fresh(['agent.user', 'approver']));
    }

    public function reject(AgentSettlement $agentSettlement, Request $request): AgentSettlementResource
    {
        $this->ensureAdminUser($request);

        $data = $request->validate([
            'reason' => ['required', 'string'],
        ]);

        try {
            $this->settlementService->reject($agentSettlement, $request->user(), $data['reason']);
        } catch (InvalidArgumentException $exception) {
            abort(422, $exception->getMessage());
        }

        return new AgentSettlementResource($agentSettlement->fresh(['agent.user', 'approver']));
    }

    private function ensureAdminUser(Request $request): void
    {
        $role = $request->user()?->role;

        if (! in_array($role, [User::ROLE_ADMIN, User::ROLE_OWNER, User::ROLE_DIRECTOR], true)) {
            abort(403, 'Only admin users can perform this action.');
        }
    }
}
