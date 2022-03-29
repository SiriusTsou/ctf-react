/**
 * SPDX-License-Identifier:MIT
 */
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@opengsn/contracts/src/forwarder/IForwarder.sol";
import "@opengsn/contracts/src/utils/GsnTypes.sol";
import "@opengsn/contracts/src/interfaces/IPaymaster.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@opengsn/contracts/src/interfaces/IStakeManager.sol";
import "@opengsn/contracts/src/interfaces/IRelayHub.sol";
import "@opengsn/contracts/src/interfaces/IRelayRecipient.sol";
import "@opengsn/contracts/src/utils/MinLibBytes.sol";
import "@opengsn/contracts/src/utils/GsnUtils.sol";
import "@opengsn/contracts/src/utils/GsnEip712Library.sol";
import "@opengsn/contracts/src/BasePaymaster.sol";

/**
 * a paymaster for a single recipient contract.
 * - reject requests if destination is not the target contract.
 * - reject any request if the target contract reverts.
 */
contract SingleRecipientPaymaster is BasePaymaster {

    address public target;

    constructor(address _target) {
        target=_target;
    }

    function versionPaymaster() external view override virtual returns (string memory){
        return "2.2.0+opengsn.recipient.ipaymaster";
    }

    function preRelayedCall(
        GsnTypes.RelayRequest calldata relayRequest,
        bytes calldata signature,
        bytes calldata approvalData,
        uint256 maxPossibleGas
    )
    external
    override
    virtual
    returns (bytes memory context, bool revertOnRecipientRevert) {
        (relayRequest, signature, approvalData, maxPossibleGas);
        require(relayRequest.request.to==target, "wrong target");
	//returning "true" means this paymaster accepts all requests that
	// are not rejected by the recipient contract.
        return ("", true);
    }

    function postRelayedCall(
        bytes calldata context,
        bool success,
        uint256 gasUseWithoutPost,
        GsnTypes.RelayData calldata relayData
    ) external override virtual {
        (context, success, gasUseWithoutPost, relayData);
    }
}
