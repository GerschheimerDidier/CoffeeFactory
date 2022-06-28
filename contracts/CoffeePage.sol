// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/** 
 * @title Coffee Page
 * @author Didier Gerschheimer
 * @dev Implements a basic BuyMeACoffee page fonctionalities
 */
contract CoffeePage {

    string public name; // page name
    string public status; // short description of what this page is about
    string public pageThumbnailUrl; // page thumbnail image
    string public pageBannerUrl; // page banner image
    string public description; // page description
    uint public coffeeCount = 0; // number of coffee bought
    
    address payable owner; // contract owner
    address deployer; // factory contract

    // donation mapping, store accumulated donation from an address
    mapping(address => uint) public donations;

    // event thrown whenever a coffee is bought
    event CoffeeBought(address indexed from, uint timestamp, uint value);

    constructor(
        address _owner, // contract owner
        string memory _name, // page name
        string memory _status, // short description of what this page is about
        string memory _pageThumbnailUrl, // page thumbnail
        string memory _pageBannerUrl, // page banner
        string memory _description // page description
    ) {
        owner = payable(_owner);
        deployer = msg.sender;

        name = _name;
        status = _status;
        pageThumbnailUrl = _pageThumbnailUrl;
        pageBannerUrl = _pageBannerUrl;
        description = _description;
    }

    /**
     * @dev Buy a coffee for the owner of this page
     */
    function buyACoffee() external payable {
        uint coffeeCost = 1000000000000000; // 0.001 ETH
        require(msg.value >= coffeeCost, "Insufficient Ether provided");
        
        (bool success, ) = owner.call{ value: msg.value }("");
        require(success, "Failed to buy coffee");

        coffeeCount++;

        emit CoffeeBought(msg.sender, block.timestamp, msg.value);
    }

    /**
     * @dev Set the page name
     * @param _name page name
     */
    function setPageName(string memory _name) external onlyOwner {
        name = _name;
    }

    /**
     * @dev Set the page short description
     * @param _status page short description
     */
    function setPageStatus(string memory _status) external onlyOwner {
        status = _status;
    }

    /**
     * @dev Set the page thumbnail
     * @param _pageThumbnailUrl page thumbnail
     */
    function setPageThumbnailUrl(string memory _pageThumbnailUrl) external onlyOwner {
        pageThumbnailUrl = _pageThumbnailUrl;
    }

    /**
     * @dev Set the page banner
     * @param _pageBannerUrl page banner
     */
    function setPageBannerUrl(string memory _pageBannerUrl) external onlyOwner {
        pageBannerUrl = _pageBannerUrl;
    }

    /**
     * @dev Set the page descriprion
     * @param _description page description
     */
    function setDescription(string memory _description) external onlyOwner {
        description = _description;
    }

    // modifier, only allows the owner of this contract to execute the function
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this");
        _;
    }

}