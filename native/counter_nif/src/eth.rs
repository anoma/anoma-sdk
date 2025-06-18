use arm::transaction::Transaction;

use evm_protocol_adapter_bindings::call::protocol_adapter;
use evm_protocol_adapter_bindings::conversion::ProtocolAdapter;
use evm_protocol_adapter_bindings::conversion::ProtocolAdapter::ProtocolAdapterErrors;

pub async fn submit(transaction: Transaction) -> bool {
    let tx = ProtocolAdapter::Transaction::from(transaction);
    let result = protocol_adapter().execute(tx).send().await;

    match result {
        Ok(transactionbuilder) => {
            Some(transactionbuilder);
            true
        }
        Err(err) => {
            println!("{:?}", err);
            let decoded_err = err.as_decoded_interface_error::<ProtocolAdapterErrors>();
            println!("error: {:?}", decoded_err);
            false
        }
    }
}