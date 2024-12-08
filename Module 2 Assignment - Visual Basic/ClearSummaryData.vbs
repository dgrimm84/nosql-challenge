Sub ClearData()

'Loop through worksheets to clear summary data
Dim ws As Worksheet
    For Each ws In ActiveWorkbook.Worksheets
        
        'Make each sheet in loop active and delete columns storing summary data
        ws.Activate
        ActiveSheet.Columns("I:Q").Delete

        'Set width of column H to leave room for buttons
        Range("H1").ColumnWidth = 18

    'Loop to next worksheet and perform summary data deletion/clearing
    Next ws

    'Activate worksheet Q1 so user can see quarter 1 data first
    Worksheets("Q1").Activate

End Sub