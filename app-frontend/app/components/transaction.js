import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

export default class TransactionComponent extends Component {

    @tracked transaction

    constructor(owner, args) {
        super(owner, args)
        this.transaction = args.transaction
    }

    get isWithdrawal(){
        return this.transaction.amount < 0
    }

}
