# 事前準備
GCPのサービスアカウント作成

GCPの必要ロール
```
compute.instanceGroupManagers.get
container.clusters.create
container.clusters.get
container.operations.get
gkehub.memberships.create
```

サービスアカウントキーを取得してコピー
```
mkdir creds
cp <YOUR_SURVICEACCOUNT_KEY_PATH> creds/account.json
```

# 環境変数の設定

```
export TF_VAR_project_name=<YOUR_PROJECT_NAME> #プロジェクト名
export TF_VAR_cluster_name=<YOUR_CLUSTER_NAME> #クラスター名
export TF_VAR_location=<YOUR_CLUSTER_LOCATION> #クラスターのリージョン ex: asia-northeast1
```
direnvを仕様しているのなら `.envrc` に記述する

# 環境構築
必要なサービスの構築
```
terraform apply
```

asmのインストール
```
%docker compose run --rm asmcli /bin/bash #docker環境にログイン

# 以下はDocker環境ないで作業する
$ gcloud auth login

$ gcloud config set project ${PROJECT_ID}

$ gcloud container clusters update $CLUSTER_NAME \
    --region=$CLUSTER_LOCATION \
    --workload-pool=${PROJECT_ID}.svc.id.goog

$ ./asmcli x install \
  -p $PROJECT_ID \
  -l $CLUSTER_LOCATION \
  -n $CLUSTER_NAME \
  --managed \
  --verbose \
  --output_dir /output \
  --use_managed_cni \
  --channel rapid \
  --enable-all
```