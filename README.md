# Практическая работа: ETL-процессы  
## Задание 1: Работа с Yandex DataTransfer

Цель: перенести данные из **Yandex DataBase (YDB)** в **Object Storage** с использованием **Yandex Data Transfer**.

---

## Содержание репозитория

```
task1/
├── img/
│   ├── transfer_status.png        # Успешное завершение трансфера
│   ├── transfer_create.png        # Настройка трансфера
│   ├── target_create.png          # Создание таргета в Object Storage
│   └── result.png                 # Результат — файл в формате Parquet
├── create_table.yql               # SQL-скрипт создания таблицы YDB
├── import_data.sh                 # Bash-скрипт для импорта данных в YDB
├── transactions_v2.csv            # Данные для загрузки
├── main.tf                        # Terraform конфигурация для развёртывания YDB и бакета
├── outputs.tf
├── providers.tf
└── variables.tf
```

---

## Этапы выполнения

1. **Развёртывание инфраструктуры**  
   Выполнить:
   ```bash
   terraform init
   terraform apply
   ```

2. **Создание таблицы и импорт данных**
   ```bash
   ./import_data.sh
   ```
   Скрипт создаёт таблицу `transactions` и загружает данные из `transactions_v2.csv`.  
   Требуется файл `oauth-token.txt` с валидным YC-токеном.

3. **Создание таргета и трансфера**
   - Вручную через [Yandex Console](https://console.cloud.yandex.ru):
     - [Создание таргета в Object Storage](task1/img/target_create.png)
     - [Создание трансфера YDB → S3](task1/img/transfer_create.png)

4. **Запуск и проверка трансфера**
   - Запустить трансфер.
   - Дождаться успешного выполнения:  
     [Успешный статус трансфера](task1/img/transfer_status.png)
   - Убедиться, что в бакете появился файл `transactions.parquet`:  
     [Результат — файл в Object Storage](task1/img/result.png)

5. **Очистка ресурсов**
   ```bash
   terraform destroy
   ```