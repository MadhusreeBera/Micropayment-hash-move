module self::micropayment_hash{
    use std::signer;
    use aptos_framework::account;
    use aptos_framework::coin;
    use std::string::String;
    use aptos_std::table::{Self, Table};
    use aptos_framework::aptos_coin::AptosCoin;
    use std::vector;

    const MODULE_OWNER:address = @self;

    const ENO_SAME_SENDER_RECEIVER:u64 = 0;
    const ENO_NOT_MODULE_OWNER:u64 = 1;



    struct Channel has store, drop{
        channel_id: u64,
        sender_address: address,
        receiver_address: address,
        initial_amount: u64,
        no_of_tokens: u64,
        redeemed: bool,
        trust_anchor: String,
    }

    struct GlobalTable has key {
        channel_table: Table<u64, Channel>,
        channel_counter:u64
    }

    public entry fun init_deploy(deployer: &signer) {
        // let signer_address = signer::address_of(account);  
        // assert!(signer_address == @self, "only owner can initialize contract")      
        assert!(signer::address_of(deployer) == MODULE_OWNER, ENO_NOT_MODULE_OWNER);

        // Initialize a resource account that maintains the list of channels
        let (_resource, signer_cap) = account::create_resource_account(deployer, vector::empty());

        let rsrc_acc_signer = account::create_signer_with_capability(&signer_cap);

        coin::register<AptosCoin>(&rsrc_acc_signer);

        // Initialize the global table
        move_to(deployer, GlobalTable {
            // store details of channels into a table
            channel_table: table::new(),
            channel_counter: 0
        });
    }

    public entry fun create_channel (sender: &signer, receiver_address: address, initial_amount: u64,no_of_tokens:u64,  trust_anchor: String) acquires GlobalTable {
       let sender_address = signer::address_of(sender);
        let global_table_resource = borrow_global_mut<GlobalTable>(MODULE_OWNER);
        let counter = global_table_resource.channel_counter + 1;
        assert!(sender_address != receiver_address, ENO_SAME_SENDER_RECEIVER);

        // MOST IMPORTANT - take payment from sender and transfer to contract
        coin::transfer<AptosCoin>(sender, MODULE_OWNER, initial_amount);

        // assert!(self::channel_exists(sender_address, receiver_address) == false, "channel already exists");
        let new_channel = Channel {
            channel_id: counter,
            sender_address: sender_address,
            receiver_address: receiver_address,
            initial_amount: initial_amount,
            no_of_tokens: no_of_tokens,
            trust_anchor: trust_anchor,
            redeemed: false
        };
        // self::set_channel(sender_address, receiver_address, channel);
        table::upsert(&mut global_table_resource.channel_table, counter, new_channel);
        global_table_resource.channel_counter = counter;
    
    }

}