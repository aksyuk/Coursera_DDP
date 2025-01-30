library('shiny')
library('data.table')

#ru список показателей для загрузки
#en list of indexes to load
indexes.list <- data.table(name = c('GDP per capita (current US$)',
                                    'GDP per capita (constant 2000 US$)',
                                    'GDP per capita, PPP (current international $)',
                                    'GDP per capita, PPP (constant 2005 international $)'),
                           indicator = c('NY.GDP.PCAP.CD',
                                         'NY.GDP.PCAP.KD',
                                         'NY.GDP.PCAP.PP.CD',
                                         'NY.GDP.PCAP.PP.KD'),
                           stringsAsFactors = F)

#ru размещение всех объектов на странице
#en objects layout
shinyUI(
    fixedPage(
        #ru название приложения:
        #en application name
        titlePanel('GDP per capita on Map'),
        
        fixedRow(
            column(width = 3, 
                   #ru слайдер по годам
                   #en slider for years
                   sliderInput('year',
                               'Select year', 
                               min = 2000, max = 2015, value = 2015, 
                               format = '####', width = "100%", sep = ''),
                   
                   #ru выбор показателя для изображения. переменная index.name
                   #en select index to show. variable index.name
                   radioButtons('index.name',
                                'Select indicator to plot:', indexes.list[, name], 
                                selected = indexes.list[1, name],
                                width = "100%")),
            
            column(width = 9, 
                   # #ru текстовый объект для отображения выбранных параметров отбора
                   # #en text output to show selected parameters
                   # textOutput('sp.text'),
                   
                   #ru карта-хороплет
                   #en choropleth map
                   div(style = "width:100%;",
                       htmlOutput('gvis.widget'))
                   )
            ),
        
        fixedRow(
            #ru описательные статистики
            #en summary statistics
            htmlOutput('summary.header'),
            verbatimTextOutput('summary')
            ),
            
        fixedRow(
            #ru текстовый объект для отображения коэффициента Джинни
            #en text output with Gini coefficient
            htmlOutput('gini.text')                    
        ),
        
        fixedRow(
            column(width = 6,
                   #ru текстовый объект для отображения первой пятёрки
                   #en text output with top-5 countries list
                   htmlOutput('top.5.header'),
                   verbatimTextOutput('top.5')),
            
            column(width = 6,
                   #ru текстовый объект для отображения последней пятёрки
                   #en text output with low-5 countries list
                   htmlOutput('low.5.header'),
                   verbatimTextOutput('low.5'))
        )
    )
) 


