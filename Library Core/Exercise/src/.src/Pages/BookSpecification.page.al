page 50701 Library
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Library;
    Caption = 'Book Specifications';
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
                field("Rented"; Rec."Rented")
                {
                    ApplicationArea = All;
                    
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
                        S : Enum Status;
                        TextVar : Text[50];
                    begin
                        TextVar := Rec.Status.Names.Get(Rec.Status.Ordinals.IndexOf(Rec.Status.AsInteger()));
                        Message(TextVar);
                    end;
                }
            }
        }
    }
   
    trigger OnModifyRecord(): Boolean
    Var
        S : Enum Status;
        TextVar : Text[50];
    begin
        // Message(Format(F.GetEnumValueOrdinal(Rec.Status)));

        Rec.UpdatePrequelSequel();
        TextVar := Status.Names.Get(Status.Ordinals.IndexOf(Status.AsInteger()));
        Message(TextVar);
        // if(Rec."Edit Sequel" = true) then
        // begin
        // libraryBooks.SetFilter("Book ID", '=%1', Rec."Prequel ID");
        // libraryBooks.FindFirst();
        // libraryBooks.Sequel := Rec.Title;
        // libraryBooks."Sequel ID" := Rec."Book ID";
        // libraryBooks.Modify();
        // end;
    end;
    //  local procedure EnumValue(Number: Integer): Text
    // begin
    //     exit(F.GetEnumValueNameFromOrdinalValue(F.GetEnumValueOrdinal(Number)));
    // end;

    // procedure GetSelectedEnum(): Integer
    // begin
    //     exit(F.GetEnumValueOrdinal(Rec.Status));
    // end;

    // procedure SetupPage(TableNo: Integer; FieldNo: Integer)
    // var
    //     SelectLbl: Label 'Select ';
    // begin
    //     Ref.OPEN(TableNo);
    //     F := Ref.Field(FieldNo);
    //     Setrange(Status, 1, F.EnumValueCount());
    //     CurrPage.Caption(SelectLbl + F.Caption());
    // end;


    procedure GetOptionNo(Value: Text; FieldRef: FieldRef): Integer
    var 
        FieldRefValueVar: Variant;  
        FieldRefValueInt: Integer; 
    begin 
        if (Value = '') and (FieldRef.GetEnumValueName (1) = ' ') then 
            exit(0);   

        FieldRefValueVar := FieldRef.Value();  
        FieldRefValueInt := -1; 

        if Evaluate (FieldRef, Value) then 
        begin 
            FieldRefValueInt := FieldRef.Value(); 
            FieldRef.Value(FieldRefValueVar); 
        end; 

        exit(FieldRefValueInt); 
    end;
    var
        Ref: RecordRef;
        F: FieldRef;
}