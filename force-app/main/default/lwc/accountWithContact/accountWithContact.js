import { LightningElement, wire } from "lwc";
import { getRecord } from "lightning/uiRecordApi";

const FIELDS = ["Account.Name", "Account.Contacts"];

export default class AccountWithContact extends LightningElement {
  actions = [
    { label: "Show details", name: "show_details" },
    { label: "Delete", name: "delete" }
  ];

  accountColumns = [
    { label: "Id", fieldName: "id" },
    { label: "Name", fieldName: "name" },
    { label: "Website", fieldName: "website", type: "url" },
    { label: "Phone", fieldName: "phone", type: "phone" },
    {
      type: "action",
      typeAttributes: { rowActions: this.actions }
    }
  ];

  accounts;
  selectedAccount;

  @wire(getRecord, { recordId: "$selectedAccount", fields: FIELDS })
  wiredAccount({ error, data }) {
    if (data) {
      this.selectedAccount = data;
    } else if (error) {
      // Handle error
    }
  }

  handleAccountClick(event) {
    const accountId = event.target.dataset.id;
    this.selectedAccount = accountId;
  }
}
