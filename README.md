# Charity Donation Tracking Module

The Charity Donation Tracking module facilitates the transparent and accountable management of charitable donations, enabling donors, recipients, and authorities to interact in a decentralized manner. It offers functionalities for making donations, tracking their purposes and amounts, validating donations by authorities, transferring donations to recipients, and managing donation cancellations.

## Struct Definitions

### Donation
- **id**: Unique identifier for the donation.
- **donor_address**: Address of the donor making the donation.
- **purpose_id**: Identifier for the purpose of the donation.
- **amount**: Amount of the donation.
- **balance**: Balance of SUI tokens representing the donated amount.
- **recipient_is_pending**: Boolean indicating whether the donation is pending receipt by the recipient.
- **authority_validation**: Boolean indicating whether the donation has been validated by the authority.

### AdminCap
- **id**: Unique identifier for administrative privileges within the charity tracking system.

### Receipt
- **id**: Unique identifier for the receipt.
- **donation**: ID of the associated donation.
- **amount_donated**: Amount donated as recorded in the receipt.

## Public - Entry Functions

### new
Allows users to create a new donation with a specified purpose and amount, returning a capability for managing the donation.

### deposit
Deposits SUI coins into the donation's balance, generating a receipt for the transaction.

### new_id
Updates the purpose ID of a pending donation, restricted to the donation's owner.

### withdraw
Allows the owner of a donation to withdraw its balance as SUI coins.

### cancel_donation
Allows the donor to cancel a donation, withdrawing the donated amount if it hasn't been received by the recipient.

## Additional Functions

### validate_donation
Allows authorities to validate a donation, marking it as validated.

### mark_donation_received
Marks a validated donation as received by the recipient.

### get_donation_details
Retrieves details of a donation, including donor address, amount, and validation status.

### update_donation_amount
Updates the amount of a donation.

### update_donation_purpose_id
Updates the purpose ID of a donation.

### is_donation_pending
Checks if a donation is pending receipt by the recipient.

### is_donation_validated
Checks if a donation has been validated by an authority.

### update_receipt_amount_donated
Updates the amount donated in a receipt.

### is_cap_owner_of_donation
Checks if a capability is the owner of a donation.

### is_cap_owner_of_receipt
Checks if a capability is the owner of a receipt.

### get_donation_purpose_id
Retrieves the purpose ID of a donation.

### get_receipt_donation_id
Retrieves the ID of the donation associated with a receipt.

### get_receipt_amount_donated
Retrieves the amount donated as recorded in a receipt.

### get_donation_donor_address
Retrieves the donor address of a donation.

### get_donation_recipient_pending_status
Retrieves the pending status of a donation.

### get_donation_authority_validation_status
Retrieves the validation status of a donation.

## Setup

### Prerequisites

1. Rust and Cargo: Install Rust and Cargo on your development machine by following the official Rust installation instructions.

2. SUI Blockchain: Set up a local instance of the SUI blockchain for development and testing purposes. Refer to the SUI documentation for installation instructions.

### Build and Deploy

1. Clone the Charity Donation Tracking repository and navigate to the project directory on your local machine.

2. Compile the smart contract code using the Rust compiler:

   ```bash
   cargo build --release
   ```

3. Deploy the compiled smart contract to your local SUI blockchain node using the SUI CLI or other deployment tools.

4. Note the contract address and other relevant identifiers for interacting with the deployed contract.

## Usage

### Making a Donation

To make a donation, invoke the `new` function with the specified purpose and amount.

### Validating a Donation

Authorities can validate a donation using the `validate_donation` function.

### Receiving a Donation

Recipients can mark a validated donation as received using the `mark_donation_received` function.

### Canceling a Donation

Donors can cancel a donation using the `cancel_donation` function.

### Managing Donation Purposes

Donation purposes can be updated using the `update_donation_purpose_id` function, restricted to pending donations.

## Interacting with the Smart Contract

### Using the SUI CLI

1. Utilize the SUI CLI to interact with the deployed smart contract, providing function arguments and transaction contexts as required.

2. Monitor transaction outputs and blockchain events to track the status of donations and transactions.

### Using Web Interfaces (Optional)

1. Develop web interfaces or applications that interact with the smart contract using JavaScript libraries such as Web3.js or Ethers.js.

2. Implement user-friendly interfaces for making donations, tracking purposes and amounts, and managing donation transactions within the Charity Donation Tracking platform.

## Conclusion

The Charity Donation Tracking Smart Contract offers a decentralized solution for managing charitable donations, fostering transparency, accountability, and efficiency in the donation process. By leveraging blockchain technology, donors, recipients, and authorities can engage in secure and transparent transactions, ultimately contributing to the greater good of society.