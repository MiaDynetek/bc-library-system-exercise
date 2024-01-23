page 50201 GradeEvaluation
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Library;
    Caption = 'Grade Evaluation';

    layout
    {
        area(Content)
        {
            group(GradingData)
            {
                Caption = 'Grading Data';
                field(Grade; Rec.Grade)
                {
                    ToolTip = 'Specifies the value of the Grade field.';
                }
                field("Grade Justification"; Rec."Grade Justification")
                {
                    ToolTip = 'Specifies the value of the Grade Justification field.';
                    MultiLine = true;
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
    trigger OnModifyRecord(): Boolean
    var
        rentBook: Record BookTransactions;
    begin
        // rentBook.SetRange("Rent ID", Rec."Rent ID");
        // rentBook.FindFirst();
        // // rentBook.SetCurrentKey("Date Rented");
        // // rentBook.Ascending();
        // // rentBook.FindLast();
        // rentBook.Grade := Rec.Grade;
        // rentBook."Grade Justification" := Rec."Grade Justification";
        // rentBook.Modify();
    end;
    
    trigger OnClosePage()
    var
        rentBook: Record BookTransactions;
    begin
        rentBook.SetRange("Rent ID", Rec."Rent ID");
        rentBook.FindFirst();
        // rentBook.SetCurrentKey("Date Rented");
        // rentBook.Ascending();
        // rentBook.FindLast();
        rentBook.Grade := Rec.Grade;
        rentBook."Grade Justification" := Rec."Grade Justification";
        rentBook.Modify();
    end;
    var
        myInt: Integer;
}