import { LightningElement, track, wire } from "lwc";
// import { getRecord } from "lightning/uiRecordApi";
import getAccountWithContact from "@salesforce/apex/AccountWithContactController.getAccountWithContact";

import ACCOUNT_NAME from "@salesforce/schema/Account.Name";
import ACCOUNT_PHONE from "@salesforce/schema/Account.Phone";
import ACCOUNT_WEBSITE from "@salesforce/schema/Account.Website";
import CONTACT_NAME from "@salesforce/schema/Contact.Name";
import CONTACT_PHONE from "@salesforce/schema/Contact.Phone";

const actions = [
  { label: "Show details", name: "show_details" },
  { label: "Delete", name: "delete" }
];

const contactColumns = [
  { label: "Id", fieldName: "Id" },
  { label: "Name", fieldName: CONTACT_NAME.fieldApiName },
  { label: "Phone", fieldName: CONTACT_PHONE.fieldApiName, type: "phone" }
];

const accountColumns = [
  { label: "Id", fieldName: "Id" },
  { label: "Name", fieldName: ACCOUNT_NAME.fieldApiName },
  { label: "Website", fieldName: ACCOUNT_WEBSITE.fieldApiName, type: "url" },
  { label: "Phone", fieldName: ACCOUNT_PHONE.fieldApiName, type: "phone" },
  {
    label: "Edit",
    type: "button",
    typeAttributes: {
      label: { fieldName: ACCOUNT_NAME.fieldApiName },
      name: "editClick",
      variant: "base",
      iconName: "utility:settings",
      tooltip: { fieldName: ACCOUNT_WEBSITE.fieldApiName }
    }
  },
  {
    type: "action",
    typeAttributes: { rowActions: actions }
  }
];

export default class AccountWithContact extends LightningElement {
  accountData;
  @track contactData; // list to show on ui, reactive

  accountColumns = accountColumns;
  contactColumns = contactColumns;

  /* This code is using the `@wire` decorator to call the Apex method `getAccountWithContact` and
  retrieve data from Salesforce. The method returns an object with two properties: `error` and
  `data`. The function `_accountData` is then called with this object as a parameter. */
  @wire(getAccountWithContact)
  _accountData({ error, data }) {
    if (data) {
      console.log(JSON.stringify(data));
      console.log(ACCOUNT_NAME);
      this.accountData = data;
    } else if (error) {
      this.accountData = null;
    }
  } // List to show on ui, Not reactive

  handleAccountClick(event) {
    const accountId = event.target.dataset.id;
    this.selectedAccount = accountId;
  }

  /**
   * This function sets the contactData variable to the Contacts of the selected row in an account
   * table.
   * @param event - The event parameter is an object that contains information about the event that
   * triggered the function.
   */
  accountRowSelection(event) {
    let row = event.detail.selectedRows.at(0);
    this.contactData = row.Contacts;
  }

  /**
   *
   * @param {*} event
   */
  handleRowAction(event) {
    const action = event.detail.action;
    console.log(action);
    console.log(JSON.stringify(event.detail));

    if (action && action.name === "show_details") {
      console.log("action happen");
    }

    if (action && action.name === "editClick") {
      console.log("edit click from button");
    }
  }
}
