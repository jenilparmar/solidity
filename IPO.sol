// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract IPO {
    struct IPO_DS {
        string name_Of_IPO;
        address[] all_sharing_stake_holder;
        bool solded;
        uint256 total_price;
    }
    struct StakeHolder {
        address owner_address;
        uint256 total_Eth;
        uint256 present_IPO_count;
        bool given_access;
    }
    mapping(uint256 => StakeHolder) public stakeholders;
    mapping(uint256 => IPO_DS) public ipoListings; // Store IPOs with an ID

    event stakeHodler_add(
        uint256 indexed stake_hodler_id,
        string owner_address,
        uint256 present_ipo_count,
        bool given_access
    );
    event IPOAdded(
        uint256 indexed ipoId,
        string name,
        address owner,
        uint256 price
    );
    uint256 public ipoCount; // Counter for IPOs
    uint256 public stakeHolderCount;

    function addStakeHolder(
        uint256 _Eth_Count,
        uint256 _present_count,
        bool _access
    ) public {
        stakeHolderCount++;
        StakeHolder memory newStakeHolder = stakeholders[stakeHolderCount];
        newStakeHolder.owner_address = msg.sender;
        newStakeHolder.total_Eth = _Eth_Count;
        newStakeHolder.given_access = _access;
        newStakeHolder.present_IPO_count = _present_count;
    }

    function applyForIPO(uint256 _ipoCount) public returns (bool) {
        IPO_DS storage gotIPO = ipoListings[_ipoCount];
        if (!gotIPO.solded) {
            gotIPO.all_sharing_stake_holder.push(msg.sender);
            return true;
        } else {
            return false;
        }
    }

    function add_IPO_DS(string memory _name_of_IPO, uint256 _price) public {
        ipoCount++;
        IPO_DS storage newIPO = ipoListings[ipoCount];
        newIPO.name_Of_IPO = _name_of_IPO;
        newIPO.total_price = _price;
        newIPO.all_sharing_stake_holder.push(msg.sender); // Add sender to stakeholders
        newIPO.solded = false;

        emit IPOAdded(ipoCount, _name_of_IPO, msg.sender, _price);
    }

    function get_IPO_DS(uint256 _IPO_count)
        public
        view
        returns (
            string memory name_Of_IPO,
            address[] memory all_sharing_stake_holder,
            bool solded,
            uint256 total_price
        )
    {
        IPO_DS memory ipo = ipoListings[_IPO_count];
        return (
            ipo.name_Of_IPO,
            ipo.all_sharing_stake_holder,
            ipo.solded,
            ipo.total_price
        );
    }
}
