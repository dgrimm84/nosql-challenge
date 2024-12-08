Sub stockcompare()

'Loop through worksheets
Dim ws As Worksheet
    For Each ws In ActiveWorkbook.Worksheets

    'Activate first/next worksheet in loop to perform calculations
    ws.Activate

        'Decalre Variables for Counters
        Dim i, j, k, a, c As Integer
        Dim b As Long
        Dim column As Integer
        
        'Declare Variable for string array for column headers and add headers names
        Dim headerarray(10) As String
        headerarray(0) = ""
        headerarray(1) = "ticker"
        headerarray(2) = "Quarterly Change"
        headerarray(3) = "Percent Change"
        headerarray(4) = "Total Stock Volume"
        headerarray(5) = ""
        headerarray(6) = ""
        headerarray(7) = ""
        headerarray(8) = "Ticker"
        headerarray(9) = "Value"
        
         
        'Declare Varible for finding last row and store last row value
        Dim lastrow As Long
        lastrow = ws.Cells(Rows.Count, 1).End(xlUp).Row
                
        'Declare Variable for finding last column and store last column value
        Dim lastcol As Long
        lastcol = ws.Cells(1, Columns.Count).End(xlToLeft).column
        
        'Loop to add 10 columnns for new data and add headers with header name array
        b = lastcol + 1
        For a = 0 To 9
            Cells(1, b).EntireColumn.Insert
            Cells(1, b).Value = headerarray(a)
            b = b + 1
        Next a
        
        'Declare Variables for summary table data
        Dim ticker As String
        Dim openvalue, closevalue, totalstockvolume, summarypercentinc, summarypercentdec As Double
        Dim summarytotalvolume, summarydatarow, summarydatalastrow As Long
        
        'Prep to to cycle through the rows to capture data
        column = 1
        summarydatarow = 2
        
        'Set the initial open value price for first ticker
        openvalue = Cells(2, 3).Value
        
        'Loop through all ticker rows
        For i = 2 To lastrow
        
            'Finds when the next cell in column 1's value does not equal the current cell's value
            If Cells(i + 1, column).Value <> Cells(i, column).Value Then
                
                'Capture data for each ticket value in each variable
                ticker = Cells(i, 1).Value
                closevalue = Cells(i, 6).Value
                totalstockvolume = totalstockvolume + Cells(i, 7).Value
                        
                'Paste the data in the summary data area
                Range("I" & summarydatarow).Value = ticker
                Range("J" & summarydatarow).Value = closevalue - openvalue
                Range("K" & summarydatarow).Value = (closevalue - openvalue) / openvalue
                Range("l" & summarydatarow).Value = totalstockvolume
                
                'Go to next summary data row
                summarydatarow = summarydatarow + 1
                
                'Set open value to next ticker row
                openvalue = Cells(i + 1, 3).Value
                
                'Reset total stock volume for next ticker
                totalstockvolume = 0
            
            'If the next cell ticker equals the prior cell value, add to total stock volume
            Else
                totalstockvolume = totalstockvolume + Cells(i, 7).Value
            End If
           
        Next i
        
        'Find last row of summary data
        summarydatalastrow = ws.Cells(Rows.Count, 9).End(xlUp).Row
        
        'Set format of columns displaying percentages to percentage format
        Range("K" & i).EntireColumn.NumberFormat = "0.00%"
        
        'Test for positive or negative results and format color for each cell in quarterly change based on that value
        For c = 2 To summarydatalastrow
            If Cells(c, 10).Value > 0 Then
                Cells(c, 10).Interior.ColorIndex = 10
                Cells(c, 11).Interior.ColorIndex = 10
            ElseIf Cells(c, 10).Value = 0 Then
                Cells(c, 10).Interior.ColorIndex = 6
                Cells(c, 11).Interior.ColorIndex = 6
            ElseIf Cells(c, 10).Value < 0 Then
                Cells(c, 10).Interior.ColorIndex = 3
                Cells(c, 11).Interior.ColorIndex = 3
            End If
        Next c
        
        'Loop through summary data to find and display tickers with greatest % increase, % decrease, and volume values
        'Properly format cells and title final summary data rows
        For k = 2 To summarydatalastrow
            If Cells(k, 11).Value = Application.WorksheetFunction.Max(Range("K2:K" & summarydatalastrow)) Then
                Cells(2, 15).Value = "Greatest % Increase"
                Cells(2, 16).Value = Cells(k, 9).Value
                Cells(2, 17).Value = Cells(k, 11).Value
                Cells(2, 17).NumberFormat = "0.00%"
            ElseIf Cells(k, 11).Value = Application.WorksheetFunction.Min(Range("K2:K" & summarydatalastrow)) Then
                Cells(3, 15).Value = "Greatest % Decrease"
                Cells(3, 16).Value = Cells(k, 9).Value
                Cells(3, 17).Value = Cells(k, 11).Value
                Cells(3, 17).NumberFormat = "0.00%"
            ElseIf Cells(k, column + 11).Value = Application.WorksheetFunction.Max(Range("L2:L" & summarydatalastrow)) Then
                Cells(4, 15).Value = "Greatest Total Volume"
                Cells(4, 16).Value = Cells(k, 9).Value
                Cells(4, 17).Value = Cells(k, 12).Value
                Cells(4, 17).NumberFormat = "#"
            End If
        Next k
        
        'Auto size columns to fit data and format header titles for ease of reading
        ActiveSheet.Range("A1:Q1").Font.Size = 12
        ActiveSheet.Range("A1:Q1").Font.Bold = True
        ActiveSheet.Range("I1:L" & summarydatalastrow).Borders.LineStyle = xlContinuous
        ActiveSheet.Range("O1:Q4").Borders.LineStyle = xlContinuous
        ActiveSheet.Columns("A:Z").AutoFit
        
        'Set width of column H to leave room for buttons
        Range("H1").ColumnWidth = 18
                
    Next ws
    
    'Activate worksheet Q1 so user can see quarter 1 data first
    Worksheets("Q1").Activate
    
End Sub
