enum TransactionType {
  Credit @alias("C")
  Debit @alias("D")
}

class AccountTransaction {
  amount float
  month string @description("Example: 'May 2024'")
}

class CashFlowData {
  account_name string
  txns AccountTransaction[]
  txn_type TransactionType
}

// Create a function to extract the resume from a string.
function ExtractCashFlowData(cash_flow_csv: string) -> CashFlowData[] {
  // Specify a client as provider/model-name
  // you can use custom LLM params with a custom client name from clients.baml like "client CustomHaiku"
  client "openai/gpt-4o" // Set OPENAI_API_KEY to use this client.
  prompt #"
    Break down the monthly cash flow from the provided spreadsheet, ignoring totals and nets:

    {{ ctx.output_format }}

    Extract from this spreadsheet:
    {{ cash_flow_csv }}
  "#
}

// Test the function with a sample resume. Open the VSCode playground to run this.
test cash_flow_data_short {
  functions [ExtractCashFlowData]
  args {
    cash_flow_csv #"
OMC Cash Flow - 12 Month,Unnamed: 1,Unnamed: 2,Unnamed: 3,Unnamed: 4,Unnamed: 5,Unnamed: 6,Unnamed: 7,Unnamed: 8,Unnamed: 9,Unnamed: 10,Unnamed: 11,Unnamed: 12,Unnamed: 13
Exported On: 01/06/2025 04:53 PM,,,,,,,,,,,,,
,,,,,,,,,,,,,
A Management Co.,,,,,,,,,,,,,
Properties: Example Property,,,,,,,,,,,,,
Period Range: Jan 2024 to Dec 2024,,,,,,,,,,,,,
Accounting Basis: Cash,,,,,,,,,,,,,
Level of Detail: Detail View,,,,,,,,,,,,,
Include Zero Balance GL Accounts: No,,,,,,,,,,,,,
,,,,,,,,,,,,,
Account Name,Jan 2024,Feb 2024,Mar 2024,Apr 2024,May 2024,Jun 2024,Jul 2024,Aug 2024,Sep 2024,Oct 2024,Nov 2024,Dec 2024,Total
Operating Income & Expense,,,,,,,,,,,,,
    Income,,,,,,,,,,,,,
        SCHEDULED RENT,,,,,,,,,,,,,
            Gross Rent Potential,0,0,0,0,57017.98,94010,94010,94010,94010,94010,94010,94010,715087.98
            Gain/(Loss) to Lease,0,0,0,0,0,-6675,-6825,-6905,-6905,-6905,-6805,-6985,-48005
        Total SCHEDULED RENT,0,0,0,0,57017.98,87335,87185,87105,87105,87105,87205,87025,667082.98
        RENT ADJUSTMENTS,,,,,,,,,,,,,
            Vacancy Loss,0,0,0,0,0,-3264.83,-2880.48,0,0,0,-3090,-1736.13,-10971.44
            Concessions,0,0,0,0,0,-1774.17,-2185.99,-39.84,0,0,-1000,0,-5000
            Current Rent Uncollected,0,0,0,0,0,-4538,-3131.5,-1425,-95,-1640,-1575,-3139.75,-15544.25
            Prepaid Rent Prior Period,0,0,0,0,0,-34232.1,-44202.29,-43879.75,-48518.5,-46470.5,-37908.5,-40959.75,-296171.39
            Prior Rent,0,0,0,0,0,530,5169.35,1706.5,4021,216,256,0,11898.85
            Prepaid Rent,0,0,0,0,34232.1,44202.29,43879.75,48518.5,46470.5,37908.5,40959.75,41909.5,338080.89
        Total RENT ADJUSTMENTS,0,0,0,0,34232.1,923.19,-3351.16,4880.41,1878,-9986,-2357.75,-3926.13,22292.66

    "#
  }
}
test cash_flow_data_medium {
  functions [ExtractCashFlowData]
  args {
    cash_flow_csv #"
OMC Cash Flow - 12 Month,Unnamed: 1,Unnamed: 2,Unnamed: 3,Unnamed: 4,Unnamed: 5,Unnamed: 6,Unnamed: 7,Unnamed: 8,Unnamed: 9,Unnamed: 10,Unnamed: 11,Unnamed: 12,Unnamed: 13
Exported On: 01/06/2025 04:53 PM,,,,,,,,,,,,,
,,,,,,,,,,,,,
A Management Co.,,,,,,,,,,,,,
Properties: Example Property,,,,,,,,,,,,,
Period Range: Jan 2024 to Dec 2024,,,,,,,,,,,,,
Accounting Basis: Cash,,,,,,,,,,,,,
Level of Detail: Detail View,,,,,,,,,,,,,
Include Zero Balance GL Accounts: No,,,,,,,,,,,,,
,,,,,,,,,,,,,
Account Name,Jan 2024,Feb 2024,Mar 2024,Apr 2024,May 2024,Jun 2024,Jul 2024,Aug 2024,Sep 2024,Oct 2024,Nov 2024,Dec 2024,Total
Operating Income & Expense,,,,,,,,,,,,,
    Income,,,,,,,,,,,,,
        SCHEDULED RENT,,,,,,,,,,,,,
            Gross Rent Potential,0,0,0,0,57017.98,94010,94010,94010,94010,94010,94010,94010,715087.98
            Gain/(Loss) to Lease,0,0,0,0,0,-6675,-6825,-6905,-6905,-6905,-6805,-6985,-48005
        Total SCHEDULED RENT,0,0,0,0,57017.98,87335,87185,87105,87105,87105,87205,87025,667082.98
        RENT ADJUSTMENTS,,,,,,,,,,,,,
            Vacancy Loss,0,0,0,0,0,-3264.83,-2880.48,0,0,0,-3090,-1736.13,-10971.44
            Concessions,0,0,0,0,0,-1774.17,-2185.99,-39.84,0,0,-1000,0,-5000
            Current Rent Uncollected,0,0,0,0,0,-4538,-3131.5,-1425,-95,-1640,-1575,-3139.75,-15544.25
            Prepaid Rent Prior Period,0,0,0,0,0,-34232.1,-44202.29,-43879.75,-48518.5,-46470.5,-37908.5,-40959.75,-296171.39
            Prior Rent,0,0,0,0,0,530,5169.35,1706.5,4021,216,256,0,11898.85
            Prepaid Rent,0,0,0,0,34232.1,44202.29,43879.75,48518.5,46470.5,37908.5,40959.75,41909.5,338080.89
        Total RENT ADJUSTMENTS,0,0,0,0,34232.1,923.19,-3351.16,4880.41,1878,-9986,-2357.75,-3926.13,22292.66
        OTHER INCOME,,,,,,,,,,,,,
            Utility Income,0,0,0,0,41.94,5003.67,5566.44,5854.77,5969,5440,5627,5327.74,38830.56
            Month-to-Month Fees,0,0,0,0,0,400,200,400,200,200,200,200,1800
            Rent Refunds,0,0,0,0,0,0,-357.88,-15.02,0,0,0,0,-372.9
            Forfeitures/Damages,0,0,0,0,0,225,1810,0,0,0,512.59,325,2872.59
            Lease Buy Out Fees,0,0,0,0,0,0,3490,0,0,0,0,0,3490
            Administrative Fees,0,0,0,0,0,0,0,0,0,0,0,600,600
            Late Charges & NSF Fees,0,0,0,0,0,0,0,0,165.85,136,292.75,0,594.6
            Pet Fees,0,0,0,0,800,400,400,400,200,0,200,200,2600
            Pet Rent,0,0,0,0,22.58,358.33,413.71,425,500,475,500,515.32,3209.94
            Laundry & Vending Income,0,0,0,0,0,0,128.58,0,0,599.95,143.98,0,872.51
            Liability Insurance Fee,0,0,0,0,0,0,0,29,43.5,7.5,12.5,-2,90.5
        Total OTHER INCOME,0,0,0,0,864.52,6387,11650.85,7093.75,7078.35,6858.45,7488.82,7166.06,54587.8
    Total Operating Income,0,0,0,0,92114.6,94645.19,95484.69,99079.16,96061.35,83977.45,92336.07,90264.93,743963.44
    Expense,,,,,,,,,,,,,
        MARKETING EXPENSE,,,,,,,,,,,,,
            Mini Models/Move In Gifts,0,0,0,0,0,0,32.22,0,0,0,0,0,32.22
            Internet Advertising,0,0,0,0,1154.51,1103.8,3498.7,2363.28,2362.4,2363.28,2663.28,2574.9,18084.15
"            Brochures, Business Cards",0,0,0,0,0,0,0,0,0,0,0,14.08,14.08
            Signage,0,0,0,0,0,0,43.36,113.73,66.12,257.95,0,291.93,773.09
            Resident Retention/Newsletters/Renewal Carpet Cleaning,0,0,0,0,0,0,0,0,157.81,384.21,0,1044.88,1586.9
        Total MARKETING EXPENSE,0,0,0,0,1154.51,1103.8,3574.28,2477.01,2586.33,3005.44,2663.28,3925.79,20490.44
        ADMINISTRATIVE EXPENSE,,,,,,,,,,,,,
            Office Supplies,0,0,0,0,1,59.34,62.52,61.44,54.31,163.05,57.9,188.17,647.73
            Postage,0,0,0,0,0,7.18,11.32,25.43,0,40.25,0,40.23,124.41
            Management Fees,0,0,0,0,0,7470.39,3819.39,3963.17,3840.85,3360.7,3693.44,3610.6,29758.54
            Training,0,0,0,0,0,0,0,0,140,0,25,0,165
            Mileage Expense,0,0,0,0,0,0,0,0,360,160,0,167.85,687.85
            Legal Expense,0,0,0,0,0,4718.75,543.93,670,-495,0,0,0,5437.68
            Accounting Expense,0,0,0,0,0,0,0,0,0,10767.82,0,0,10767.82
            Telephone/Cable/Internet,0,0,0,0,48.28,142.74,182.19,152.72,145.76,158.42,160.21,154.47,1144.79
            Technology Services,0,0,0,0,251.61,439.61,373.62,325,325,366.82,543.32,325,2949.98
            AppFolio Fees,0,0,0,0,127.97,166.3,176.3,175.3,174.56,170.3,165.3,165.3,1321.33
            Miscellaneous Administrative,0,0,0,0,0,44,0,168.45,49.1,0,0,212.17,473.72
        Total ADMINISTRATIVE EXPENSE,0,0,0,0,428.86,13048.31,5169.27,5541.51,4594.58,15187.36,4645.17,4863.79,53478.85
        PAYROLL EXPENSES,,,,,,,,,,,,,
            Manager's Salary,0,0,0,0,2125.76,3336.83,3152.87,3101.42,4599.89,3125.78,4497.57,2884.41,26824.53
            Assistant Manager's Salar,0,0,0,0,0,0,164.48,0,0,0,0,0,164.48
            Maintenance Payroll,0,0,0,0,1663.42,2287.14,3140.47,2560.01,2674.31,2799.06,3989.01,2523.51,21636.93
            Assistant Maintenance P/R,0,0,0,0,1421.43,1905.12,2734.2,2240.28,2246.87,2308.51,3297.39,2116.8,18270.6
            Payroll Tax Expense,0,0,0,0,658.7,930.35,1298.75,1228.08,1283.25,1200.07,1618.69,1007.33,9225.22
            Employee Health Insurance,0,0,0,0,0,20.42,18.27,57.59,937.88,-883.47,20.42,20.42,191.53
            Employee Benefits,0,0,0,0,0,2.47,0,10.26,0,0,0,0,12.73
        Total PAYROLL EXPENSES,0,0,0,0,5869.31,8482.33,10509.04,9197.64,11742.2,8549.95,13423.08,8552.47,76326.02
    "#
  }
}
test cash_flow_data_long {
  functions [ExtractCashFlowData]
  args {
    cash_flow_csv #"
OMC Cash Flow - 12 Month,Unnamed: 1,Unnamed: 2,Unnamed: 3,Unnamed: 4,Unnamed: 5,Unnamed: 6,Unnamed: 7,Unnamed: 8,Unnamed: 9,Unnamed: 10,Unnamed: 11,Unnamed: 12,Unnamed: 13
Exported On: 01/06/2025 04:53 PM,,,,,,,,,,,,,
,,,,,,,,,,,,,
A Management Co.,,,,,,,,,,,,,
Properties: Example Property,,,,,,,,,,,,,
Period Range: Jan 2024 to Dec 2024,,,,,,,,,,,,,
Accounting Basis: Cash,,,,,,,,,,,,,
Level of Detail: Detail View,,,,,,,,,,,,,
Include Zero Balance GL Accounts: No,,,,,,,,,,,,,
,,,,,,,,,,,,,
Account Name,Jan 2024,Feb 2024,Mar 2024,Apr 2024,May 2024,Jun 2024,Jul 2024,Aug 2024,Sep 2024,Oct 2024,Nov 2024,Dec 2024,Total
Operating Income & Expense,,,,,,,,,,,,,
    Income,,,,,,,,,,,,,
        SCHEDULED RENT,,,,,,,,,,,,,
            Gross Rent Potential,0,0,0,0,57017.98,94010,94010,94010,94010,94010,94010,94010,715087.98
            Gain/(Loss) to Lease,0,0,0,0,0,-6675,-6825,-6905,-6905,-6905,-6805,-6985,-48005
        Total SCHEDULED RENT,0,0,0,0,57017.98,87335,87185,87105,87105,87105,87205,87025,667082.98
        RENT ADJUSTMENTS,,,,,,,,,,,,,
            Vacancy Loss,0,0,0,0,0,-3264.83,-2880.48,0,0,0,-3090,-1736.13,-10971.44
            Concessions,0,0,0,0,0,-1774.17,-2185.99,-39.84,0,0,-1000,0,-5000
            Current Rent Uncollected,0,0,0,0,0,-4538,-3131.5,-1425,-95,-1640,-1575,-3139.75,-15544.25
            Prepaid Rent Prior Period,0,0,0,0,0,-34232.1,-44202.29,-43879.75,-48518.5,-46470.5,-37908.5,-40959.75,-296171.39
            Prior Rent,0,0,0,0,0,530,5169.35,1706.5,4021,216,256,0,11898.85
            Prepaid Rent,0,0,0,0,34232.1,44202.29,43879.75,48518.5,46470.5,37908.5,40959.75,41909.5,338080.89
        Total RENT ADJUSTMENTS,0,0,0,0,34232.1,923.19,-3351.16,4880.41,1878,-9986,-2357.75,-3926.13,22292.66
        OTHER INCOME,,,,,,,,,,,,,
            Utility Income,0,0,0,0,41.94,5003.67,5566.44,5854.77,5969,5440,5627,5327.74,38830.56
            Month-to-Month Fees,0,0,0,0,0,400,200,400,200,200,200,200,1800
            Rent Refunds,0,0,0,0,0,0,-357.88,-15.02,0,0,0,0,-372.9
            Forfeitures/Damages,0,0,0,0,0,225,1810,0,0,0,512.59,325,2872.59
            Lease Buy Out Fees,0,0,0,0,0,0,3490,0,0,0,0,0,3490
            Administrative Fees,0,0,0,0,0,0,0,0,0,0,0,600,600
            Late Charges & NSF Fees,0,0,0,0,0,0,0,0,165.85,136,292.75,0,594.6
            Pet Fees,0,0,0,0,800,400,400,400,200,0,200,200,2600
            Pet Rent,0,0,0,0,22.58,358.33,413.71,425,500,475,500,515.32,3209.94
            Laundry & Vending Income,0,0,0,0,0,0,128.58,0,0,599.95,143.98,0,872.51
            Liability Insurance Fee,0,0,0,0,0,0,0,29,43.5,7.5,12.5,-2,90.5
        Total OTHER INCOME,0,0,0,0,864.52,6387,11650.85,7093.75,7078.35,6858.45,7488.82,7166.06,54587.8
    Total Operating Income,0,0,0,0,92114.6,94645.19,95484.69,99079.16,96061.35,83977.45,92336.07,90264.93,743963.44
    Expense,,,,,,,,,,,,,
        MARKETING EXPENSE,,,,,,,,,,,,,
            Mini Models/Move In Gifts,0,0,0,0,0,0,32.22,0,0,0,0,0,32.22
            Internet Advertising,0,0,0,0,1154.51,1103.8,3498.7,2363.28,2362.4,2363.28,2663.28,2574.9,18084.15
"            Brochures, Business Cards",0,0,0,0,0,0,0,0,0,0,0,14.08,14.08
            Signage,0,0,0,0,0,0,43.36,113.73,66.12,257.95,0,291.93,773.09
            Resident Retention/Newsletters/Renewal Carpet Cleaning,0,0,0,0,0,0,0,0,157.81,384.21,0,1044.88,1586.9
        Total MARKETING EXPENSE,0,0,0,0,1154.51,1103.8,3574.28,2477.01,2586.33,3005.44,2663.28,3925.79,20490.44
        ADMINISTRATIVE EXPENSE,,,,,,,,,,,,,
            Office Supplies,0,0,0,0,1,59.34,62.52,61.44,54.31,163.05,57.9,188.17,647.73
            Postage,0,0,0,0,0,7.18,11.32,25.43,0,40.25,0,40.23,124.41
            Management Fees,0,0,0,0,0,7470.39,3819.39,3963.17,3840.85,3360.7,3693.44,3610.6,29758.54
            Training,0,0,0,0,0,0,0,0,140,0,25,0,165
            Mileage Expense,0,0,0,0,0,0,0,0,360,160,0,167.85,687.85
            Legal Expense,0,0,0,0,0,4718.75,543.93,670,-495,0,0,0,5437.68
            Accounting Expense,0,0,0,0,0,0,0,0,0,10767.82,0,0,10767.82
            Telephone/Cable/Internet,0,0,0,0,48.28,142.74,182.19,152.72,145.76,158.42,160.21,154.47,1144.79
            Technology Services,0,0,0,0,251.61,439.61,373.62,325,325,366.82,543.32,325,2949.98
            AppFolio Fees,0,0,0,0,127.97,166.3,176.3,175.3,174.56,170.3,165.3,165.3,1321.33
            Miscellaneous Administrative,0,0,0,0,0,44,0,168.45,49.1,0,0,212.17,473.72
        Total ADMINISTRATIVE EXPENSE,0,0,0,0,428.86,13048.31,5169.27,5541.51,4594.58,15187.36,4645.17,4863.79,53478.85
        PAYROLL EXPENSES,,,,,,,,,,,,,
            Manager's Salary,0,0,0,0,2125.76,3336.83,3152.87,3101.42,4599.89,3125.78,4497.57,2884.41,26824.53
            Assistant Manager's Salar,0,0,0,0,0,0,164.48,0,0,0,0,0,164.48
            Maintenance Payroll,0,0,0,0,1663.42,2287.14,3140.47,2560.01,2674.31,2799.06,3989.01,2523.51,21636.93
            Assistant Maintenance P/R,0,0,0,0,1421.43,1905.12,2734.2,2240.28,2246.87,2308.51,3297.39,2116.8,18270.6
            Payroll Tax Expense,0,0,0,0,658.7,930.35,1298.75,1228.08,1283.25,1200.07,1618.69,1007.33,9225.22
            Employee Health Insurance,0,0,0,0,0,20.42,18.27,57.59,937.88,-883.47,20.42,20.42,191.53
            Employee Benefits,0,0,0,0,0,2.47,0,10.26,0,0,0,0,12.73
        Total PAYROLL EXPENSES,0,0,0,0,5869.31,8482.33,10509.04,9197.64,11742.2,8549.95,13423.08,8552.47,76326.02
        UTILITIES,,,,,,,,,,,,,
            Clubhouse Electricity,0,0,0,0,0,63.26,135.28,66.08,55.25,0,86.33,156.04,562.24
            Electricity,0,0,0,0,0,140.56,431.84,211.59,193.16,44.44,221.41,265.94,1508.94
            Vacant Units Electricity,0,0,0,0,0,64.29,108.03,59.14,18.37,10.08,0,66.09,326
            Water,0,0,0,0,0,1253.6,2617.44,2136.74,2918.45,3003.63,2540.18,2599.27,17069.31
            Sewer,0,0,0,0,0,3359.29,5829.36,5019.02,4824.66,4774.8,4184.34,4242.96,32234.43
            Storm,0,0,0,0,0,0,0,0,0,2262.62,0,0,2262.62
            Refuse,0,0,0,0,0,1005.25,1298.45,1298.45,1298.45,1298.45,1298.45,1261.65,8759.15
        Total UTILITIES,0,0,0,0,0,5886.25,10420.4,8791.02,9308.34,11394.02,8330.71,8591.95,62722.69
        MAINTENANCE,,,,,,,,,,,,,
            Carpet Cleaning/Repairs,0,0,0,0,0,75,0,0,0,0,0,0,75
            Blind Cleaning / Repair,0,0,0,0,0,0,0,0,73.84,0,0,0,73.84
            Pest Control,0,0,0,0,0,183.46,183.46,187.08,183.46,183.46,183.46,183.46,1287.84
            Landscape,0,0,0,0,1420.3,1834.56,1834.56,1900.1,1935.27,1873.38,1834.56,1834.56,14467.29
            General Parts / Repairs,0,0,0,0,0,181.21,170.35,677.47,496.34,0,0,0,1525.37
            Appliance Parts / Repairs,0,0,0,0,0,677.03,721.13,-677.03,0,174.64,0,0,895.77
            Electrical Parts / Repairs,0,0,0,0,0,24.02,0,0,318.59,215.35,0,0,557.96
            Plumbing Parts / Repairs,0,0,0,0,0,0,135.53,117.06,0,0,19.66,480.58,752.83
            Tools & Equipment,0,0,0,0,0,53.55,0,46.66,0,0,18.12,239.8,358.13
            Fire Ext & Alarm,0,0,0,0,0,189.41,0,0,0,0,0,0,189.41
            Painting Supplies / Vendors,0,0,0,0,0,19.65,0,89.83,150.72,0,0,0,260.2
            Doors,0,0,0,0,0,0,344.11,0,0,0,0,0,344.11
        Total MAINTENANCE,0,0,0,0,1420.3,3237.89,3389.14,2341.17,3158.22,2446.83,2055.8,2738.4,20787.75
        TURNOVER COSTS,,,,,,,,,,,,,
            Turnover - Carpet Cleaning,0,0,0,0,0,0,0,0,0,0,238,0,238
            Turnover - Painting,0,0,0,0,0,159.79,315.51,0,0,29.49,316.84,0,821.63
            Turnover - Blinds,0,0,0,0,0,0,0,0,349.03,0,111.63,0,460.66
            Turnover - Plumbing,0,0,0,0,0,240.01,0,0,0,0,0,0,240.01
            Turnover - Electrical,0,0,0,0,0,101.61,0,0,0,0,46.36,0,147.97
            Turnover - Doors / Trim,0,0,0,0,0,0,0,0,0,0,52.64,0,52.64
            Turnover - Cleaning,0,0,0,0,0,675,375,0,0,0,0,0,1050
            Turnover - Other,0,0,0,0,0,197.37,0,0,0,0,0,0,197.37
            Turnover - Trash Out,0,0,0,0,0,503.6,0,0,0,0,0,575,1078.6
        Total TURNOVER COSTS,0,0,0,0,0,1877.38,690.51,0,349.03,29.49,765.47,575,4286.88
        TAXES & INSURANCE,,,,,,,,,,,,,
            Real Estate Taxes,0,0,0,0,0,9019,9019,9019,9019,9019,9019,9019,63133
            Misc. Taxes & Permits,0,0,0,0,0,188.14,359.06,192.57,179.75,199.45,171.67,171.67,1462.31
            Insurance,0,0,0,0,0,50616.54,4700,4700,4700,4700,4700,4700,78816.54
        Total TAXES & INSURANCE,0,0,0,0,0,59823.68,14078.06,13911.57,13898.75,13918.45,13890.67,13890.67,143411.85
    Total Operating Expense,0,0,0,0,8872.98,93459.64,47830.7,42259.92,45637.45,54531.54,45774.18,43138.07,381504.48
,,,,,,,,,,,,,
    NOI - Net Operating Income,0,0,0,0,83241.62,1185.55,47653.99,56819.24,50423.9,29445.91,46561.89,47126.86,362458.96
,,,,,,,,,,,,,
Other Income & Expense,,,,,,,,,,,,,
    Other Expense,,,,,,,,,,,,,
        PROPERTY EXPENSE,,,,,,,,,,,,,
            Mortgage Interest,0,0,0,0,0,26644.5,26644.5,26644.5,26644.5,26644.5,26644.5,26644.5,186511.5
            Capital - Carpet / Flooring,0,0,0,0,0,969.6,0,0,0,0,666.39,347.68,1983.67
            Capital - Appliances,0,0,0,0,0,0,1641.34,0,103.82,0,736.19,0,2481.35
            Capital - Renovations+A76:A119,0,0,0,0,0,1440.08,0,0,0,0,0,0,1440.08
        Total PROPERTY EXPENSE,0,0,0,0,0,29054.18,28285.84,26644.5,26748.32,26644.5,28047.08,26992.18,192416.6
    Total Other Expense,0,0,0,0,0,29054.18,28285.84,26644.5,26748.32,26644.5,28047.08,26992.18,192416.6
,,,,,,,,,,,,,
    Net Other Income,0,0,0,0,0,-29054.18,-28285.84,-26644.5,-26748.32,-26644.5,-28047.08,-26992.18,-192416.6
,,,,,,,,,,,,,
    Total Income,0,0,0,0,92114.6,94645.19,95484.69,99079.16,96061.35,83977.45,92336.07,90264.93,743963.44
    Total Expense,0,0,0,0,8872.98,122513.82,76116.54,68904.42,72385.77,81176.04,73821.26,70130.25,573921.08
,,,,,,,,,,,,,
    Net Income,0,0,0,0,83241.62,-27868.63,19368.15,30174.74,23675.58,2801.41,18514.81,20134.68,170042.36
,,,,,,,,,,,,,
    Other Items,,,,,,,,,,,,,
        Cash-Tax/Insurance Reserve,0,0,0,0,0,-9019,-13719,-13719,-13719,31374.43,-13719,-13719,-46239.57
        Petty Cash,0,0,0,0,0,-1000,0,0,0,0,0,0,-1000
        Cash -Security Deposits,0,0,0,0,-37910,-1300,1075,0,0,0,1000,-258.06,-37393.06
        Accrued Property Taxes,0,0,0,0,0,9019,9019,9019,9019,-36074.43,9019,9019,18039.57
        Accrued Property Insuranc,0,0,0,0,0,0,4700,4700,4700,4700,4700,4700,28200
        Security Deposits,0,0,0,0,37910,1300,-1075,0,0,0,-1000,258.06,37393.06
        Owner's Contribution,0,0,0,0,0,50876.97,0,0,0,0,0,0,50876.97
    Net Other Items,0,0,0,0,0,49876.97,0,0,0,0,0,0,49876.97
,,,,,,,,,,,,,
Cash Flow,0,0,0,0,83241.62,22008.34,19368.15,30174.74,23675.58,2801.41,18514.81,20134.68,219919.33
,,,,,,,,,,,,,
Beginning Cash,0,0,0,0,0,83241.62,105249.96,124618.11,154792.85,178468.43,181269.84,199784.65,0
Beginning Cash + Cash Flow,0,0,0,0,83241.62,105249.96,124618.11,154792.85,178468.43,181269.84,199784.65,219919.33,219919.33
Actual Ending Cash,0,0,0,0,83241.62,105249.96,124618.11,154792.85,178468.43,181269.84,199784.65,219919.33,219919.33

    "#
  }
}
