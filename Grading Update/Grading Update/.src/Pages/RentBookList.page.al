page 50200 RentBookList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "BookTransactions";
    Caption = 'Rented Book List';
    CardPageId = RentBook;
    DelayedInsert = true;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                
                
                field("Book Name"; Rec."Book Name")
                {
                    ToolTip = 'Specifies the value of the Book Name field.';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.';
                }
                field("Date Rented"; Rec."Date Rented")
                {
                    ToolTip = 'Specifies the value of the Date Rented field.';
                }
                field("Return Date"; Rec."Return Date")
                {
                    ToolTip = 'Specifies the value of the Return Date field.';
                }
                field("Days Rented"; Rec."Days Rented")
                {
                    ToolTip = 'Specifies the value of the Days Rented field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Book Rented field. If the value is true, the book is rented, if it is false, the book is not rented.';
                }
            }
        }
     
    } 
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        Rec.SetFilter(Status,'=%1 | %2',enum::Statuses::Rented,enum::Statuses::Available);
        //Rec.SetFilter(Status,'=Rented | Available');
    end;
}