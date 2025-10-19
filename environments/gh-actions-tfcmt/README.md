# tfcmt検証環境

## 概要

GitHub Actionsとtfcmtを使用して、Terraform planの結果をPRにコメントする機能を検証するための環境です。

## tfcmtとは

tfcmt (Terraform Comment)は、Terraformの実行結果をGitHub PRにコメントとして投稿するCLIツールです。

- リポジトリ: https://github.com/suzuki-shunsuke/tfcmt
- ドキュメント: https://suzuki-shunsuke.github.io/tfcmt/

### 主な機能

- Terraform planの結果をPRコメントに自動投稿
- リソース変更のサマリー表示
- 変更内容に応じたカラーラベルの自動付与
  - `add-or-update`: リソースの作成または更新
  - `destroy`: リソースの削除または再作成

## 検証内容

1. PR作成時に自動でterraform planを実行
2. tfcmtを使用してplan結果をPRにコメント
3. `-patch`オプションでコメントの更新動作を確認

## 事前準備

### AWS認証の設定

GitHub ActionsからAWSリソースにアクセスするため、OIDC認証を設定する必要があります。

1. AWS側でOIDCプロバイダーを設定
2. GitHub Actions用のIAMロールを作成（S3フルアクセス権限）
3. GitHubリポジトリのSecretsに`AWS_ROLE_ARN`を追加

**参考**: https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services

または、Access KeyとSecret Access Keyを使用する場合は、ワークフローの認証ステップを以下に変更：

```yaml
- name: Configure AWS credentials
  uses: aws-actions/configure-aws-credentials@v4
  with:
    aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
    aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
    aws-region: ${{ env.AWS_REGION }}
```

## 使用方法

### 1. PRの作成

```bash
git checkout -b feature/test-tfcmt
# 任意の変更を加える
git add .
git commit -m "test tfcmt"
git push origin feature/test-tfcmt
```

### 2. GitHub Actionsの確認

PRを作成すると、`.github/workflows/terraform-tfcmt-plan.yml`が自動実行されます。

### 3. PRコメントの確認

GitHub ActionsによってTerraform planの結果がPRにコメントされます。

## Terraformリソース

このサンプルでは以下のAWSリソースを作成します：

- S3バケット（バージョニング有効）

## 参考

- [tfcmt GitHub Repository](https://github.com/suzuki-shunsuke/tfcmt)
- [tfcmt Documentation](https://suzuki-shunsuke.github.io/tfcmt/)
- [GitHub Actions でterraform planの結果をコメント](https://zenn.dev/kuuki/articles/terraform-tfcmt-in-github-actions)
