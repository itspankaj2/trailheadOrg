import { LightningElement, wire } from 'lwc';

import { createMessageContext, MessageContext, subscribe, unsubscribe} from 'lightning/messageService';
import demo1 from '@salesforce/messageChannel/demo1__c';


export default class MessageChannel2 extends LightningElement {
    message = '';

    @wire(MessageContext)
    messageContext;


    // Standard lifecycle hooks used to sub/unsub to message channel
    connectedCallback() {
        this.subscribeToMessageChannel();
    }

    subscribeToMessageChannel() {
        this.subscription = subscribe(
            this.messageContext,
            demo1,
            (message) => this.handleMessage(message)
        );
    }

     // Handler for message received by component
     handleMessage(message) {
        this.message = message.recordId;
    }

    
}