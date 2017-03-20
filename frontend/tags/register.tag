<register>
    <div class="panel-heading">
        <button class="btn btn-default pull-left page-nav">
            &larr;
            <span class="hidden-xs">Back</span>
        </button>
        <div class="panel-title page-title text-center">
            <div class="h4">Register</div>
        </div>
    </div>
    <div class="panel-body">
        <form class="form-horizontal" onsubmit={ register }>
            <legend class="text-center">Create wallet</legend>
            <div class="form-group">
                <div class="col-sm-4 control-label">Your name:</div>
                <div class="col-sm-8">
                    <input type="text" class="form-control" onkeyup="{ edit }">
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-4 col-sm-8">
                    <button type="submit" class="btn btn-lg btn-primary" disabled={ !name }>Create wallet</button>
                    <a href="#" class="btn btn-lg btn-default">Back</a>
                </div>
            </div>
        </form>
    </div>

    <script>
        var self = this;

        edit(e) {
            this.name = e.target.value;
        }

        register(e) {
            e.preventDefault();
            var pair = self.api.cryptocurrency.keyPair();
            var transaction = self.api.cryptocurrency.createWalletTransaction(pair.publicKey, self.name, pair.secretKey);

            self.api.submitTransaction.call(self, transaction, pair.publicKey, function() {
                self.localStorage.addUser({
                    name: self.name,
                    publicKey: pair.publicKey,
                    secretKey: pair.secretKey
                });
                self.notify('success', 'Wallet has been created. Login and manage the wallet.');
                route('/');
            });
        }
    </script>
</register>