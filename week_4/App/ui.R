
library('shiny')
library('data.table')

# список показателей для загрузки
indexes.list <- data.table(name = c('GDP per capita (current US$)',
                                    'GDP per capita (constant 2000 US$)',
                                    'GDP per capita, PPP (current international $)',
                                    'GDP per capita, PPP (constant 2005 international $)'),
                           indicator = c('NY.GDP.PCAP.CD',
                                         'NY.GDP.PCAP.KD',
                                         'NY.GDP.PCAP.PP.CD',
                                         'NY.GDP.PCAP.PP.KD'),
                           stringsAsFactors = F)

# размещение всех объектов на странице
shinyUI(
    # создать страницу с боковой панелью и главной областью для отчётов
    fluidPage(
        # название приложения:
        headerPanel('GDP per capita on Map'),
        # боковая панель
        sidebarPanel(
            # слайдер по годам
            sliderInput('year',
                        'Select year', 
                        min = 2000, max = 2015, value = 2015, format = '####'),
            # выпадающее меню: показатели для изображения
            radioButtons('index.name',   # связанная переменная
                        'Select indicator to plot:', indexes.list[, name], 
                        selected = indexes.list[1, name])
        ),
        # главная область
        mainPanel(
            # # текстовый объект для отображения выбранных параметров отбора
            # textOutput('sp.text'),
            # карта
            htmlOutput('gvis.widget'),
            # описательные статистики
            htmlOutput('summary.header'),
            verbatimTextOutput('summary'),
            # текстовый объект для отображения коэффициента Джинни
            htmlOutput('gini.text'),
            fluidRow(
                column(6,
                    # текстовый объект для отображения первой пятёрки
                    htmlOutput('top.5.header'),
                    verbatimTextOutput('top.5')),
                column(6,
                    # текстовый объект для отображения последней пятёрки
                    htmlOutput('low.5.header'),
                    verbatimTextOutput('low.5'))
                )
            )
        )
    )
