# Charity Donation Tracking Module

The Charity Donation Tracking module facilitates the transparent and accountable management of charitable donations, enabling donors, recipients, and authorities to interact in a decentralized manner. It offers functionalities for making donations, tracking their purposes and amounts, validating donations by authorities, transferring donations to recipients, and managing donation cancellations.

## Struct Definitions

### Donation
- **id**: Unique identifier for the donation.
- **donor_address**: Address of the donor making the donation.
- **purpose_id**: Identifier for the purpose of the donation.
- **amount**: Amount of the donation.
- **donation_fund**: Balance of SUI tokens representing the donated amount.
- **recipient_is_pending**: Boolean indicating whether the donation is pending receipt by the recipient.
- **authority_validation**: Boolean indicating whether the donation has been validated by the authority.

### AdminCap
- **id**: Unique identifier for administrative privileges within the charity tracking system.

### AuthorityCap
- **id**: Unique identifier for authority privileges, allowing designated authorities to validate donations.

## Public - Entry Functions

### make_donation
Allows users to make a donation by creating a new donation object with the provided purpose and amount.

### create_authority_cap
Creates a capability for authority to validate donations.

### edit_purpose_id
Allows editing the purpose ID of a donation, restricted to pending donations.

### allocate_donation
Allocates donation funds to a specific purpose, ensuring there are enough funds available.

### validate_with_authority
Allows the authority to validate a donation.

### receive_by_recipient
Allows the recipient to receive a donation, transferring the donation fund and ownership.

### claim_by_authority
Allows the authority to claim a donation after validation.

### cancel_donation
Allows the donor to cancel a donation, refunding the donation amount if not yet received by the recipient.

## Additional Functions

### validate_donation
Allows the authority to validate a donation, marking it as validated.

### reject_donation
Allows the authority to reject a donation, returning the donation amount to the donor.

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

To make a donation, invoke the `make_donation` function with the specified purpose and amount.

### Validating a Donation

Authorities can validate or reject donations using the `validate_with_authority` or `reject_donation` functions, respectively.

### Receiving a Donation

Recipients can receive donations using the `receive_by_recipient` function, transferring the donation fund and ownership.

### Canceling a Donation

Donors can cancel donations that have not yet been received by the recipient using the `cancel_donation` function.

### Managing Donation Purposes

Donation purposes can be edited using the `edit_purpose_id` function, restricted to pending donations.

## Interacting with the Smart Contract

### Using the SUI CLI

1. Utilize the SUI CLI to interact with the deployed smart contract, providing function arguments and transaction contexts as required.

2. Monitor transaction outputs and blockchain events to track the status of donations and transactions.

### Using Web Interfaces (Optional)

1. Develop web interfaces or applications that interact with the smart contract using JavaScript libraries such as Web3.js or Ethers.js.

2. Implement user-friendly interfaces for making donations, tracking purposes and amounts, and managing donation transactions within the Charity Donation Tracking platform.

## Conclusion

The Charity Donation Tracking Smart Contract offers a decentralized solution for managing charitable donations, fostering transparency, accountability, and efficiency in the donation process. By leveraging blockchain technology, donors, recipients, and authorities can engage in secure and transparent transactions, ultimately contributing to the greater good of society.