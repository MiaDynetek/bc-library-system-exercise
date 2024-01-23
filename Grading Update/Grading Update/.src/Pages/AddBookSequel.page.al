page 50212 AddBookSequel
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Library;
    Caption = 'Book Sequel';
    DelayedInsert = true;
    
    layout
    {
        area(Content)
        {
            group("Book Information")
            {
                field("Title"; Rec."Title")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        if Rec."Title" = '' then
                        begin
                            Message('Please enter the book title.');
                        end;
                    end;
                }
                field("Author"; Rec."Author")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        if Rec."Author" = '' then
                        begin
                            Message('Please enter the book Author.'); 
                        end;
                    end;
                }
                field("Series"; Rec."Series")
                {
                    Lookup = true;
                    TableRelation = BookSeries;
                    ToolTip = 'Specifies the value of the Series Name field.';
                    
                }
                field("Genre"; Rec."Genre")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        if Rec."Genre" = '' then
                        begin
                            Message('Please enter the book Genre.'); 
                        end;
                    end;
                }
                field("Publisher"; Rec."Publisher")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        if Rec."Publisher" = '' then
                        begin
                            Message('Please enter the book Publisher.'); 
                        end;
                    end;
                }
                field("Book Price"; Rec."Book Price")
                {
                    ApplicationArea = All;
                     trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        if Rec."Book Price" = '' then
                        begin
                            Message('Please enter the book Price.'); 
                        end;
                    end;
                }
                field("Publication Date"; Rec."Publication Date")
                {
                    ApplicationArea = All;
                    
                }
                field("Pages"; Rec."Pages")
                {
                    ApplicationArea = All;
                }
                field("Prequel"; Rec."Prequel")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                 field("Sequel"; Rec."Sequel")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Edit Sequel"; Rec."Edit Sequel")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Prequel ID"; Rec."Prequel ID")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Sequel ID"; Rec."Sequel ID")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                
                field(Status; Rec.Status)
                {
                    ApplicationArea = All; 
                    trigger OnValidate()
                    var
                        S : Enum Statuses;
                        TextVar : Text[50];
                    begin
                        if (Rec.Status <> enum::Statuses::"Pending Grading") and (Rec."Display Message" = true) then
                        begin
                            Rec.Status := enum::Statuses::"Pending Grading";
                            Message('Please assess the condition of the book and update the grade field accordingly. (To be able to change the status, please update the grading or grading justification fields. The Grade field should not be empty.)');
                        end;
                        // if Rec."Display Message" = true then begin
                        //     Editable := true;
                        // end;
                        //  if Rec."Display Message" <> true then begin
                        //     Editable := false;
                        // end;
                    end;
                }
                field(Grade; Rec.Grade)
                {
                    ToolTip = 'Specifies the value of the Grade field.';
                    trigger OnValidate()
                    begin
                        if Rec."Display Message" = true then begin
                           // Rec.Status := enum::Statuses::Available;
                            Rec."Display Message" := false;
                        end;
                    end;
                }
                field("Grade Justification"; Rec."Grade Justification")
                {
                    ToolTip = 'Specifies the value of the Grade Justification field.';
                    MultiLine = true;
                    trigger OnValidate()
                    begin
                        if (Rec."Display Message" = true) and (Rec.Grade <> enum::Statuses::" ") then begin
                         //   Rec.Status := enum::Statuses::Available;
                            Rec."Display Message" := false;
                        end;
                    end;
                }
                field("Display Message"; Rec."Display Message")
                {
                    ToolTip = 'Specifies the value of the Display Message field.';
                    Visible = false;
                }

            }
        }
    }
   
    trigger OnModifyRecord(): Boolean
    Var
        S : Enum Statuses;
        TextVar : Text[50];
    begin
        Rec.UpdatePrequelSequel();
       
    end;
    trigger OnOpenPage()
    begin
        if (Rec."Display Message" = true) then begin
        Message('Please assess the condition of the book and update the grade field accordingly. (To be able to change the status, please update the grading or grading justification fields. The Grade field should not be empty.)');   

        end;
                   
    end;
    
    trigger OnClosePage()
    var
        newLog: Record BookTransactions;
    begin
        newLog.Init();
        newLog."Book Name" := Rec.Title;
        newLog."Book ID" := Rec."Book ID";
        newLog.Validate(Status, Rec.Status);
        newLog.Grade := Rec.Grade;
        newLog."Grade Justification" := Rec."Grade Justification";
        newLog.Insert();
    end;
}