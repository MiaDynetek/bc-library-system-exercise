pageextension 50251 LibraryBookListExt extends LibraryBookList
{
    layout
    {
        // Add changes to page layout here
    }
    
    actions
    {
        area(Processing)
        {
            
            action("Books that are Receiving Repair")
            {
                Caption = 'Books that are Receiving Repair';
                ToolTip = 'Select this action to view all books that are receiving repair.';
                ApplicationArea = All;
                Image = Import;
                trigger OnAction()
                begin
                    Rec.FilterReceivingRepair();
                end;
            }
             action("Archive Book")
            {
                Caption = 'Archive Book';
                ToolTip = 'Select this action to Archive the selected book.';
                ApplicationArea = All;
                Image = Import;
                trigger OnAction()
                begin
                    Rec.ArchiveBook();
                end;
            }
        }
    }
    
    var
        myInt: Integer;
}