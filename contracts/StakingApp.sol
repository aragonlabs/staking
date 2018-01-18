pragma solidity ^0.4.15;

import "@aragon/core/contracts/apps/App.sol";
import "@aragon/core/contracts/common/Initializable.sol";
import "@aragon/core/contracts/common/IForwarder.sol";

import "@aragon/core/contracts/common/MiniMeToken.sol";

// TODO: `deposit` function for increasing a stake
// TODO: `withdraw` function for decreasing a stake
// TODO: Add events (deposit, withdraw, pool state updated)
// TODO: Add script runner interface
contract StakingApp is App, Initializable, IForwarder {
    MiniMeToken public token;
    uint256 public minDeposit;

    public bytes32 TRANSITION_POOL_STATE_ROLE = bytes32(1);

    enum PoolState { None, A, B }

    struct Pool {
        mapping(address => uint) stakes;
        PoolState state; 
    }

    mapping (bytes32 => Pool) public pools;

    function initialize(
        MiniMeToken _token,
        uint256 _minDeposit
    ) onlyInit public {
        initialized();

        token = _token;
        minDeposit = _minDeposit;
        // TODO: More parameters (e.g. payout rate for the different outcomes)
    }

    function stake(
        bytes32 _poolId,
        uint256 _amount,
        PoolState _stateStakedFor
    ) public {
        // TODO: Create the pool if it does not exist
        require(_stateStakedFor != PoolState.None);
        require(pools[_poolId].state == PoolState.None);
        require(_amount >= minDeposit);

        token.transferFrom(msg.sender, this, _amount);
        pools[_poolId].stakes[msg.sender] += _amount;
    }

    function claimReward(
        bytes32 _poolId
    ) public {
        require(pools[_poolId].state != PoolState.None);

        // TODO: Determine reward, such that no tokens are leftover based on `pool.state`
    }

    function transitionPoolState(
        bytes32 _poolId,
        PoolState _newState
    ) public auth(TRANSITION_POOL_STATE_ROLE) {
        require(pools[_poolId].state == PoolState.None);

        pools[_poolId].state = _newState;
    }

    function canForward(
        address _sender,
        bytes _script
    ) public constant returns (bool) {
        return token.balanceOf(_sender) >= minDeposit;
    }

    function forward(
        bytes _script
    ) public {
        // TODO: Add pool transition transaction to script
        // TODO: Are they staking for outcome A or B?
        stake(sha3(_script), minDeposit);
        runScript(_script);
    }
}
