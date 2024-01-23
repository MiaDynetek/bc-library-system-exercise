page 50211 BookTransactions
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = BookTransactions;
    Caption = 'Book Transactions';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                Caption = 'Transactions';
               
                field("Book Name"; Rec."Book Name")
                {
                    ToolTip = 'Specifies the value of the Book Name field.';
                }
                field("Return Date"; Rec."Return Date")
                {
                    ToolTip = 'Specifies the value of the Return Date field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Book Rented field. If the value is true, the book is rented, if it is false, the book is not rented.';
                }
                field("Book ID"; Rec."Book ID")
                {
                    ToolTip = 'Specifies the value of the Rent ID field.';
                    Visible = false;
                }
                field(Grade; Rec.Grade)
                {
                    ToolTip = 'Specifies the value of the Grade field.';
                }
                field("Grade Justification"; Rec."Grade Justification")
                {
                    ToolTip = 'Specifies the value of the Grade Justification field.';
                }

            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            // action(ActionName)
            // {
            //     ApplicationArea = All;
                
            //     trigger OnAction()
            //     begin
                    
            //     end;
            // }
        }
    }
    // trigger OnOpenPage()
    // var
    //     myInt: Integer;
    // begin
    //     Rec.SetFilter(Status,'=%1',enum::Statuses::);
    // end;
    var
        myInt: Integer;
}