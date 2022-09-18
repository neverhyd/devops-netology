# Домашнее задание к занятию "10.01. Зачем и что нужно мониторить"

1. Вас пригласили настроить мониторинг на проект. На онбординге вам рассказали, что проект представляет из себя 
платформу для вычислений с выдачей текстовых отчетов, которые сохраняются на диск. Взаимодействие с платформой 
осуществляется по протоколу http. Также вам отметили, что вычисления загружают ЦПУ. Какой минимальный набор метрик вы
выведите в мониторинг и почему?
- Загрузка ЦПУ, для рассчета уровня обслуживания.
- Кол-во генерирующихся отчетов, для рассчета уровня обслуживания.
- Доступность платформы по http, выполнение требований целевого уровня качества. 
- Кол-во сгенериронных отчетов, для рассчета уровня обслуживания.
- Объем заполненного и свободного дискового пространства, для прогназирования объема для генерации кокого-то кол-ва отчетов.
- Время затарченное на обработку выдачи запроса к платформе, для понимания сколько запросов платформа обработает в ед. вермени.

1. Предложу договорится о целевом уровне качества обслуживания, скажем о доступности его продукта клиентам и соглашение об уровне
   обслуживания, в котором будет оговорено как часто и в каком количесвте гарантируется генерация отчетов.

1. Использовать бесплатные решения, например ELK, Grafana Loki.

1.
Ошибка в формуле, где не учтены 3xx коды. Верная формула из лекции: SLI = (summ_2xx_requests + summ_3xx_requests)/(summ_all_requests)

---