page 50209 RentBook
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = BookTransactions;
    Caption = 'Rent and Return Book';
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                Caption = 'Rent/Return Book';
                field("Book Name"; Rec."Book Name")
                {

                    ToolTip = 'Specifies the value of the Book Name field.';
                    Editable = false;
                }
                field("Status"; Rec."Status")
                {
                    ToolTip = 'Specifies the value of the Book Rented field. If the value is true, the book is rented, if it is false, the book is not rented.';
                    Editable = false;
                    trigger OnValidate()
                    var
                        Grade: Page GradeEvaluation;
                        
                    begin
                        //Page.RunModal(Page::LibraryBookList,Rec);
                        // Grade.RunModal();
                        // rentedBooks.SetRange("Book ID", Rec."Book ID");
                        // rentedBooks.SetCurrentKey("Date Rented");
                        // rentedBooks.Ascending();
                        // rentedBooks.FindLast();
                        // if (Rec.Status = enum::Statuses::Available) and (rentedBooks.Status = enum::Statuses::Rented) then begin
                        //     Message('Please assess the condition of the book and, if needed, update the grade field accordingly.');
                        //     Rec.Validate(Status, Statuses::Rented);
                        //     Rec.Modify();       
                        // end;
                    end;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.';
                }
                field("Date Rented"; Rec."Date Rented")
                {
                    ToolTip = 'Specifies the value of the Date Rented field.';
                }
                field("Rent ID"; Rec."Rent ID")
                {
                    ToolTip = 'Specifies the value of the Rent ID field.';
                    Visible = false;
                }
                field("Book ID"; Rec."Book ID")
                {
                    ToolTip = 'Specifies the value of the Rent ID field.';
                    Visible = false;
                }
                field("Return Date"; Rec."Return Date")
                {
                    ToolTip = 'Specifies the value of the Date Returned field.';
                    Editable = false;
                }
                field("Days Rented"; Rec."Days Rented")
                {
                    ToolTip = 'Specifies the value of the Days Rented field.';
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        if Rec."Days Rented" > 5 then begin
                            Message('Please provide a number between 1-5.');
                        end;
                        if Rec."Days Rented" <= 5 then begin
                           // Rec."Return Date" := Today();
                            Rec."Return Date" := Rec."Date Rented" + Rec."Days Rented";
                        end;
                    end;
                }
                field(Grade; Rec.Grade)
                {
                    ToolTip = 'Specifies the value of the Grade field.';
                    trigger OnValidate()
                    begin
                        if Rec."Display Message" = true then begin
                            Rec.Status := enum::Statuses::Available;
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
                            Rec.Status := enum::Statuses::Available;
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
    var

        rentedBooks: Record BookTransactions;
    begin

        Rec.UpdateRentedBook();


    end;
    trigger OnClosePage()
    var
        myInt: Integer;
    begin
    end;
    trigger OnOpenPage()
    var
        rentedBooks: Record BookTransactions;
    begin
        rentedBooks.SetRange("Book ID", Rec."Book ID");
        rentedBooks.SetCurrentKey("Date Rented");
        rentedBooks.Ascending();
        rentedBooks.FindLast();
        if (Rec."Display Message" = true) then begin
        Message('Please assess the condition of the book and update the grade field accordingly. (To change the status to available, please update the grading or grading justification fields. The Grade field should not be empty.)');   
        end;
        // if (rentedBooks.Status = enum::Statuses::Rented) then begin
        // Message('Please assess the condition of the book and, if needed, update the grade field accordingly.');   
        // end;
        //Rec."Days Rented" := 1;
        // books.SetRange("Book ID", Rec."Book ID");
        // books.FindFirst();
        // books."Rent ID" := Rec."Rent ID";
        // books.Modify();
    end;
    var
        myInt: Integer;
        BookTitle: Text[100];
        RentedBooks: Record BookTransactions;
}