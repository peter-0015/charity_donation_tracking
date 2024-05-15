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
}

