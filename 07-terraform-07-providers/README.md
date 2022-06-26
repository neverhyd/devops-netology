# Домашнее задание к занятию "7.6. Написание собственных провайдеров для Terraform."

## Задача 1. 
1. - [Resources](https://github.com/hashicorp/terraform-provider-aws/blob/e624f5ee38669a68a545acdca21d26314472e03c/internal/provider/provider.go#L909)
   - [data_source](https://github.com/hashicorp/terraform-provider-aws/blob/e624f5ee38669a68a545acdca21d26314472e03c/internal/provider/provider.go#L425)
   
1. Вероятно речь про этот [пареметр] (https://github.com/hashicorp/terraform-provider-aws/blob/e624f5ee38669a68a545acdca21d26314472e03c/internal/service/sqs/queue.go#L82)
    * Конфликтует с ```ConflictsWith: []string{"name_prefix"}```
    * регулярное выражение `^[a-zA-Z0-9_-]{1,75}\.fifo$` или `^[a-zA-Z0-9_-]{1,80}$` и длина соотвественно 80 сим.
    