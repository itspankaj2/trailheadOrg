import { LightningElement, wire } from 'lwc';

import demo1 from '@salesforce/messageChannel/demo1__c';


import { publish, MessageContext } from 'lightning/messageService';

export default class MessageChannel1 extends LightningElement {

    @wire(MessageContext)
    messageContext
    message = '';

    onchange(event) {
        this.message = event.target.value;
    }

    handleClick() {
        const payload = { recordId: this.message };
        publish(this.messageContext, demo1, payload);
    }
}