# �������� ������� � ������� "7.6. ��������� ����������� ����������� ��� Terraform."

## ������ 1. 
1. - [Resources](https://github.com/hashicorp/terraform-provider-aws/blob/e624f5ee38669a68a545acdca21d26314472e03c/internal/provider/provider.go#L909)
   - [data_source](https://github.com/hashicorp/terraform-provider-aws/blob/e624f5ee38669a68a545acdca21d26314472e03c/internal/provider/provider.go#L425)
   
1. �������� ���� ��� ���� [��������] (https://github.com/hashicorp/terraform-provider-aws/blob/e624f5ee38669a68a545acdca21d26314472e03c/internal/service/sqs/queue.go#L82)
    * ����������� � ```ConflictsWith: []string{"name_prefix"}```
    * ���������� ��������� `^[a-zA-Z0-9_-]{1,75}\.fifo$` ��� `^[a-zA-Z0-9_-]{1,80}$` � ����� ������������� 80 ���.
    