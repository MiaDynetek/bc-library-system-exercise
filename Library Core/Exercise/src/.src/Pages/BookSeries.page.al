page 50715 BookSeries
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = BookSeries;
    DelayedInsert = true;
   layout
    {
        area(Content)
        {
            repeater(General)
            {
                
                field("Series Name"; Rec."Series Name")
                {
                    
                    ToolTip = 'Specifies the value of the Series Name field.';
                    // trigger OnValidate()
                    // var
                    //     myInt: Integer;
                    // begin
                    //     if Rec."Series Name" = '' then
                    //     begin
                    //         Message('Works');
                    //        //Error('Please enter the series name.'); 
                    //     end;
                    // end;
                }
            }
        }
    }
   
}