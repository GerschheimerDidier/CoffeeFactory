// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./CoffeePage.sol";

/** 
 * @title Coffee Factory
 * @author Didier Gerschheimer
 * @dev Factory for creating CoffeePage contracts
 */
contract CoffeeFactory {

    CoffeePage[] public coffeePages; // created pages

    // Event emited on coffee page creation
    event PageCreated(address indexed page, uint timestamp, string name, string status);

    /**
     * @notice Create your own coffee page
     * @dev Create a new CoffeePage contract
     * @param _name Page name
     * @param _status Short message about what this page is about
     * @param _pageThumbnailUrl Thumbnail image to display on the page
     * @param _pageBannerUrl Page banner image
     * @param _description Page description
     */
    function createPage(
        string memory _name,
        string memory _status,
        string memory _pageThumbnailUrl,
        string memory _pageBannerUrl,
        string memory _description
    ) external {
        CoffeePage page = new CoffeePage(msg.sender, _name, _status, _pageThumbnailUrl, _pageBannerUrl, _description);
        coffeePages.push(page);

        emit PageCreated(address(page), block.timestamp, _name, _status);
    }
}
