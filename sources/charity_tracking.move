#[allow(unused_variable)]
module Charity::charity_tracking {

    // Imports
    use sui::transfer;
    use sui::sui::SUI;
    use sui::coin::{Self, Coin};
    use sui::object::{Self, UID, ID};
    use sui::balance::{Self, Balance};
    use sui::tx_context::{Self, TxContext};

    // Errors
    const ERecipientPending: u64 = 0;
    const ENotOwner: u64 = 1;
    const ENotValidatedByAuthority: u64 = 2;

    // Struct definitions
    struct AdminCap has key { id: UID }

    struct Donation has key, store {
        id: UID,                            // Donation object ID
        donor_address: address,             // Donor address
        purpose_id: u64,                    // Purpose ID
        amount: u64,                        // Donation amount
        balance: Balance<SUI>,        // SUI Balance
        recipient_is_pending: bool,         // True if the recipient has received the donation
        authority_validation: bool          // True if the authority has validated the donation
    }

    struct DonationCap has key {
        id: UID,
        to: ID 
    }

    struct Receipt has key {
        id: UID,
        donation: ID,
        amount_donated: u64,    
    }

    // Module initializer
    fun init(ctx: &mut TxContext) {
        transfer::transfer(AdminCap {
            id: object::new(ctx),
        }, tx_context::sender(ctx))
    }

    public fun amount(donation: &Donation): u64 {
        donation.amount
    }

    public fun is_received(donation: &Donation): u64 {
        balance::value(&donation.balance)
    }

    public fun authority_has_validated(donation: &Donation): bool {
        donation.authority_validation
    }

    // Public - Entry functions
    public fun new(purpose_id: u64, amount: u64, ctx: &mut TxContext) : DonationCap {
        let id_ = object::new(ctx);
        let inner_ = object::uid_to_inner(&id_);
        transfer::share_object(Donation {
            id: id_,
            donor_address: tx_context::sender(ctx),
            purpose_id: purpose_id,
            amount: amount,
            balance: balance::zero(),
            recipient_is_pending: false,
            authority_validation: false
        });
        DonationCap{
            id: object::new(ctx),
            to: inner_
        }
    }

    public fun deposit(self: &mut Donation, coin:Coin<SUI>, ctx:&mut TxContext) : Receipt {
        let id_ = object::id(self);
        let amount = coin::value(&coin);
        coin::put(&mut self.balance, coin);

        Receipt {
            id: object::new(ctx),
            donation: id_,
            amount_donated: amount
        }
    }

    public fun new_id(cap: &DonationCap, donation: &mut Donation, purpose_id: u64 ) {
        assert!(cap.to == object::id(donation), ENotOwner);
        assert!(donation.recipient_is_pending, ERecipientPending);
        donation.purpose_id = purpose_id;
    }
    
    public fun withdraw(cap: &DonationCap, donation: &mut Donation, ctx: &mut TxContext) : Coin<SUI> {
        assert!(cap.to == object::id(donation), ENotOwner);
        // Transfer the balance
        let amount = balance::value(&donation.balance);
        let fund = coin::take(&mut donation.balance, amount, ctx);
        fund
    }

    // Additional function: Cancel Donation
    public fun cancel_donation(donation: &mut Donation, receipt: Receipt, ctx: &mut TxContext) : Coin<SUI> {
        assert!(object::id(donation) == receipt.donation, ENotOwner);
        let Receipt {
            id,
            donation: _,
            amount_donated,
        } = receipt;
        object::delete(id);
        let fund = coin::take(&mut donation.balance, amount_donated, ctx);
        fund
    }
    // Additional function: Validate Donation
    public fun validate_donation(donation: &mut Donation, ctx: &mut TxContext) {
        assert!(donation.recipient_is_pending, ERecipientPending);
        donation.authority_validation = true;
    }

    // Additional function: Mark Donation as Received
    public fun mark_donation_received(donation: &mut Donation, ctx: &mut TxContext) {
        assert!(donation.authority_validation, ENotValidatedByAuthority);
        donation.recipient_is_pending = false;
    }

    // Additional function: Get Donation Details
    public fun get_donation_details(donation: &Donation): (address, u64, bool, bool) {
        (donation.donor_address, donation.amount, donation.recipient_is_pending, donation.authority_validation)
    } 

    // Additional function: Update Donation Amount
    public fun update_donation_amount(donation: &mut Donation, new_amount: u64) {
        donation.amount = new_amount;
    }

    // Additional function: Update Donation Purpose ID
    public fun update_donation_purpose_id(donation: &mut Donation, new_purpose_id: u64) {
        donation.purpose_id = new_purpose_id;
    }

    // Additional function: Check if Donation is Pending
    public fun is_donation_pending(donation: &Donation): bool {
        donation.recipient_is_pending
    }

    // Additional function: Check if Donation is Validated by Authority
    public fun is_donation_validated(donation: &Donation): bool {
        donation.authority_validation
    }

    // Additional function: Update Receipt Amount Donated
    public fun update_receipt_amount_donated(receipt: &mut Receipt, new_amount_donated: u64) {
        receipt.amount_donated = new_amount_donated;
    }

    // Additional function: Check if Cap is Owner of Donation
    public fun is_cap_owner_of_donation(cap: &DonationCap, donation: &Donation): bool {
        cap.to == object::id(donation)
    }

    // Additional function: Check if Cap is Owner of Receipt
    public fun is_cap_owner_of_receipt(cap: &DonationCap, receipt: &Receipt): bool {
        cap.to == receipt.donation
    }
    
    // Additional function: Get Donation Purpose ID
    public fun get_donation_purpose_id(donation: &Donation): u64 {
        donation.purpose_id
    }
   
    // Additional function: Get Receipt Donation ID
    public fun get_receipt_donation_id(receipt: &Receipt): ID {
        receipt.donation
    }
    // Additional function: Get Receipt Amount Donated
    public fun get_receipt_amount_donated(receipt: &Receipt): u64 {
        receipt.amount_donated
    }
   
    // Additional function: Get Donation Donor Address
    public fun get_donation_donor_address(donation: &Donation): address {
        donation.donor_address
    }
    // Additional function: Get Donation Recipient Pending Status
    public fun get_donation_recipient_pending_status(donation: &Donation): bool {
        donation.recipient_is_pending
    }
    // Additional function: Get Donation Authority Validation Status
    public fun get_donation_authority_validation_status(donation: &Donation): bool {
        donation.authority_validation
    }
}
   