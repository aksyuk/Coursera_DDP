library('data.table')
library('googleVis')
library('WDI')
library('reldist')

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

# серверная часть приложения shiny
shinyServer(function(input, output) {
    
    # реагирующая таблица с данными
    DT <-  reactive({
        na.omit(data.frame(WDI(indicator = indexes.list[name == input$index.name, indicator], 
                               start = input$year, end = input$year))[48:264, ])
    })
    
    # output$sp.text <- renderText({
    #     paste0('Selected indicator code: ',
    #           indexes.list[name == input$index.name, name],
    #           ' Year: ', input$year)
    #     }) 
    
    # таблица данных в отчёте
    output$gvis.widget <- renderGvis({
        
        g.chart <- gvisGeoChart(data = DT(), 
                                locationvar = 'iso2c', 
                                colorvar = colnames(DT())[3], 
                                options = list(dataMode = 'regions'))
        # вставляем результат в html-документ
        return(g.chart)
    })
    
    # сводка по статистике
    output$summary.header <- renderPrint({
        cat('<h3>Summary statistics:</h3>')
    })
    output$summary <- renderPrint({
        summary(DT()[, 3])
    })
    
    # коэффициент Джинни
    output$gini.text <- renderPrint({
        cat('<h3><a href = "https://en.wikipedia.org/wiki/Gini_coefficient">Gini coefficient</a> for selected indicator: ',
            '<b>', round(gini(DT()[, 3]), 2), '</b></h3>')
    })
    
    # Top 5
    output$top.5.header <- renderPrint({
        cat('<h3>Top 5:</h3>')
    })
    output$top.5 <- renderPrint({
        DT()[order(-DT()[, 3]), 2:3][1:5, ]
    })
    
    # Low 5
    output$low.5.header <- renderPrint({
        cat('<h3>Low 5:</h3>')
    })
    output$low.5 <- renderPrint({
        DT()[order(DT()[, 3]), 2:3][1:5, ]
    })
})

