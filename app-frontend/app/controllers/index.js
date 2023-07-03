import Controller from '@ember/controller';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object'

export default class IndexController extends Controller {
    @tracked accountId = ""
    @tracked amount = ""
    @tracked validationError = ""
    @tracked transactions

    async init() {
        super.init(...arguments)
        this.transactions = await this.fetchTransactions()
    }

    @action
    async submit(event) {
        event.preventDefault();
        if (!this.validate(this.amount, this.accountId)) {
            this.validationError = "Account Id is invalid or amount is not a number."
            return
        }
        const body = { "amount": parseInt(this.amount), "account_id": this.accountId }
        await fetch('http://127.0.0.1:8080/transactions', {
            headers: {
                "Content-Type": "application/json"
            },
            method: 'POST',
            body: JSON.stringify(body),
        }).then(response => console.log(response));
        this.clearForm()
        this.transactions = await this.fetchTransactions()
    }

    clearForm() {
        this.accountId = ""
        this.amount = ""
        this.validationError = ""
    }

    @action
    updateAccountId(event) {
        this.accountId = event.target.value
    }

    @action
    updateAmount(event) {
        this.amount = event.target.value
    }

    validate(amount, accountId) {
        const uuidRegex = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/
        const isNumberRegex = /^-?\d+\.?\d*$/
        return isNumberRegex.test(amount) && uuidRegex.test(accountId)
    }

    async fetchTransactions() {
        let response = await fetch('http://127.0.0.1:8080/transactions');
        let transactions = await response.json()
        if (transactions.length === 0) {
            return transactions
        }
        let latest_transaction = transactions[0]
        response = await fetch(`http://127.0.0.1:8080/accounts/${latest_transaction.account_id}`)
        let account = await response.json()
        transactions[0]["balance"] = account.balance
        return transactions
    }
}
