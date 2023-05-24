function Get-Average
{
    <#
    .Synopsis
        Gets an average
    .Description
        Gets an average of a series of numbers
    .Example
        Get-Average 2,4,6,8
    #>
    param(
    # The numbers to average
    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,Position=0)]
    [Double[]]
    $Number
    )
    
    begin {
        $numberSeries = New-Object Collections.ArrayList
    }
    
    process {
        $null = $numberSeries.AddRange($number)
    }
    
    end {
        $scriptBlock = "
# Start the total at zero
`$total = 0
"
        foreach ($n in $numberSeries) {
            $scriptBlock += "
# Add $n to the total
`$total += $n
"            
        }
        
        $scriptBlock += "
# The average is the total divided by the number of items $($numberSeries.Count)
`$average = `$total / $($numberSeries.Count)
"

        $sb=  [ScriptBlock]::Create($scriptBlock)        
        
        $null = . $sb
        $average
    }
} 
$1 = $args[0]
Get-Average $1