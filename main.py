import asyncio
import pandas as pd
from baml_client import b

def read_excel_file(file_path):
    # Read the Excel file
    df = pd.read_excel(file_path)
    csv_string = df.to_csv(index=False)
    
    return csv_string

async def main():
    excel_file = "bennbollay-property-december-preliminary.xlsx"
    cash_flow_csv_string = read_excel_file(excel_file)
    cash_flow_data_stream = b.stream.ExtractCashFlowData(cash_flow_csv=cash_flow_csv_string)

    async for cash_flow_data in cash_flow_data_stream:
        print(".", end="", flush=True)
    
    print(cash_flow_data_stream.get_final_response())

if __name__ == "__main__":
    asyncio.run(main())


