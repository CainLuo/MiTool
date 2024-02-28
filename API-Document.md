# API文档


### 米游社log
https://log-upload.mihoyo.com/log/bbs_app/upload
参数
```json
{
    "sign": "1fgpWBP8BwbaXk8\/qNj+gzhWlx4=",
    "content": "CgAS\/gYKCTE4MjY5MjkzNhIDaW9zGgppUGhvbmUxNCwzIgYxNy4zLjEqJEFGQTVEQkQ3LUQwMjctNDAyQi05NTIyLTFEOUE0QTVFRkI4NTIGMi42OC4xOghhcHBzdG9yZUINCghpc19uaWdodBIBMEIUCg5iYXR0ZXJ5X3N0YXR1cxICODVCDAoHaXNfcm9vdBIBMEIRCgxwcm94eV9zdGF0dXMSATBCEwoMdmVyc2lvbl9jb2RlEgM0MzRCDQoGdm9sdW1lEgMwLjVCIQoPcGhvbmVfY2hpcF9pbmZvEg5DUFVfVFlQRV9BUk02NEIYChJhcHBfdXNlX2xvY2FsX2RheXMSAjYyQhIKDWNoYXJnZV9zdGF0dXMSATFCEQoMbmV0d29ya190eXBlEgExQhkKEG1vYmlsZV9vcGVyYXRvcnMSBS0tLC0tQhQKDHJlc29sdXRpb25feRIEMjc3OEIUCgxyZXNvbHV0aW9uX3gSBDEyODRCQgoXYWNjZXNzYmlsZV9zZXJ2aWNlX2xpc3QSJ1NoYWtlVG9VbmRvRW5hYmxlZCxWaWRlb0F1dG9wbGF5RW5hYmxlZELeAgoKbWh5X2FidGVzdBLPAlt7InRlc3RfbmFtZSI6IjUxNjRfMzg2IiwiY29uZmlnIjp7ImlzX2xpdmUiOiIxIn0sInZlcnNpb24iOiIyIn0seyJ0ZXN0X25hbWUiOiI1MzQ3XzU4MyIsImNvbmZpZyI6e30sInZlcnNpb24iOiIyIn0seyJ0ZXN0X25hbWUiOiI1MzA4XzU0MiIsImNvbmZpZyI6e30sInZlcnNpb24iOiIyIn0seyJ2ZXJzaW9uIjoiMiIsImNvbmZpZyI6IiIsInRlc3RfbmFtZSI6IjUxMDBfNjg3In0seyJjb25maWciOnt9LCJ0ZXN0X25hbWUiOiI1MjgzXzUxMiIsInZlcnNpb24iOiIxIn0seyJjb25maWciOnsiZW5hYmxlIjoidHJ1ZSJ9LCJ2ZXJzaW9uIjoiMiIsInRlc3RfbmFtZSI6IjUyMzZfNDE4In1dQiYKEXNjcmVlbl9icmlnaHRuZXNzEhEwLjU1MDAwMDAxMTkyMDkyOUIaCglkZXZpY2VfZnASDTM4ZDdmMzQ5ZTkzZDhCFAoKdG90YWxfdGltZRIGMzg5NzQ3QgwKB2lzX3RlZW4SATAaxgUKDTE3MDgzNDQwNTc3ODgQBjoUCgpjc21fc291cmNlEgZteXNlbGY67gQKBGRhdGES5QRbeyJzZXJ2ZXJfaXAiOiIyMDMuMTA3LjYwLjc3IiwiYW1vdW50IjoiODk3IiwiY29uc3VtZV90eXBlIjoidXBsb2FkIiwiZGF0YV90eXBlIjoiYXBpIiwidXJsIjoiaHR0cHM6XC9cL2Jicy1hcGkubWl5b3VzaGUuY29tXC91c2VyXC9hcGlcL3JlcGx5UGVybWlzc2lvbiJ9LHsic2VydmVyX2lwIjoiMjAzLjEwNy42MC43NyIsImFtb3VudCI6IjQzNSIsInVybCI6Imh0dHBzOlwvXC9iYnMtYXBpLm1peW91c2hlLmNvbVwvdXNlclwvYXBpXC9yZXBseVBlcm1pc3Npb24iLCJkYXRhX3R5cGUiOiJhcGkiLCJjb25zdW1lX3R5cGUiOiJkb3dubG9hZCJ9LHsic2VydmVyX2lwIjoiMTA2LjE0LjExOS4yMCIsInVybCI6Imh0dHBzOlwvXC9sb2ctdXBsb2FkLm1paG95by5jb21cL2xvZ1wvYmJzX2FwcFwvdXBsb2FkIiwiZGF0YV90eXBlIjoiYXBpIiwiY29uc3VtZV90eXBlIjoidXBsb2FkIiwiYW1vdW50IjoiMzA0MDgifSx7InVybCI6Imh0dHBzOlwvXC9sb2ctdXBsb2FkLm1paG95by5jb21cL2xvZ1wvYmJzX2FwcFwvdXBsb2FkIiwiYW1vdW50IjoiMzczIiwiZGF0YV90eXBlIjoiYXBpIiwiY29uc3VtZV90eXBlIjoiZG93bmxvYWQiLCJzZXJ2ZXJfaXAiOiIxMDYuMTQuMTE5LjIwIn1dOhoKCXNlc3Npb25JRBINMTcwODM0NDA1Nzc4ODoQCgtpc19jb2xkYm9vdBIBMA==|CgAS9gMKCTE4MjY5MjkzNhIDaW9zGgppUGhvbmUxNCwzIgYxNy4zLjEqJEFGQTVEQkQ3LUQwMjctNDAyQi05NTIyLTFEOUE0QTVFRkI4NTIGMi42OC4xOghhcHBzdG9yZULeAgoKbWh5X2FidGVzdBLPAlt7InRlc3RfbmFtZSI6IjUxNjRfMzg2IiwiY29uZmlnIjp7ImlzX2xpdmUiOiIxIn0sInZlcnNpb24iOiIyIn0seyJ0ZXN0X25hbWUiOiI1MzQ3XzU4MyIsImNvbmZpZyI6e30sInZlcnNpb24iOiIyIn0seyJ0ZXN0X25hbWUiOiI1MzA4XzU0MiIsImNvbmZpZyI6e30sInZlcnNpb24iOiIyIn0seyJ2ZXJzaW9uIjoiMiIsImNvbmZpZyI6IiIsInRlc3RfbmFtZSI6IjUxMDBfNjg3In0seyJjb25maWciOnt9LCJ0ZXN0X25hbWUiOiI1MjgzXzUxMiIsInZlcnNpb24iOiIxIn0seyJjb25maWciOnsiZW5hYmxlIjoidHJ1ZSJ9LCJ2ZXJzaW9uIjoiMiIsInRlc3RfbmFtZSI6IjUyMzZfNDE4In1dQhoKCWRldmljZV9mcBINMzhkN2YzNDllOTNkOEIMCgdpc190ZWVuEgEwQg0KCGlzX25pZ2h0EgEwGn4KDTE3MDgzNDQwNTkzODUQBzoQCghkdXJhdGlvbhIEMTU5NzoUCgpjc21fc291cmNlEgZteXNlbGY6GwoKc3RhcnRfdGltZRINMTcwODM0NDA1Nzc4ODoKCgRkYXRhEgJbXToaCglzZXNzaW9uSUQSDTE3MDgzNDQwNTc3ODg=|CpkGEg5Ib21lTXlzZWxmUGFnZTIISG9tZVBhZ2U66AUKDHN0YXR1c192YWx1ZRLXBVt7InZhbHVlIjoiMCIsInBvc2l0aW9uIjoiR2V0Q29pbiIsInR5cGUiOiJkb3QifSx7InZhbHVlIjoiMSIsInR5cGUiOiJkb3QiLCJwb3NpdGlvbiI6IkV4Y2hhbmdDb2luIn0seyJ2YWx1ZSI6IjAiLCJwb3NpdGlvbiI6IkdhbWVDZW50ZXIiLCJ0eXBlIjoiZG90In0seyJ0eXBlIjoiZG90IiwicG9zaXRpb24iOiJRdWVzdGlvbm5haXJlIiwidmFsdWUiOiIwIn0seyJwb3NpdGlvbiI6IktvbFNob3AiLCJ2YWx1ZSI6IjAiLCJ0eXBlIjoiZG90In0seyJ0eXBlIjoiZG90IiwicG9zaXRpb24iOiJSb2xlTWFuYWdlIiwidmFsdWUiOiIwIn0seyJwb3NpdGlvbiI6IlRpbWVMaW1pdEFjdCIsInZhbHVlIjoiMCIsInR5cGUiOiJkb3QifSx7InBvc2l0aW9uIjoiVmlwU2VydmljZSIsInR5cGUiOiJkb3QiLCJ2YWx1ZSI6IjAifSx7InBvc2l0aW9uX2lkIjoiSG9tZVRhYiIsInBvc2l0aW9uIjoiQm90dG9tVGFiQmFyIiwidmFsdWUiOiIwIiwidHlwZSI6ImRvdCJ9LHsicG9zaXRpb25faWQiOiJEeW5hbWljVGFiIiwidmFsdWUiOiIxIiwicG9zaXRpb24iOiJCb3R0b21UYWJCYXIiLCJ0eXBlIjoiZG90In0seyJwb3NpdGlvbl9pZCI6Ik1lc3NhZ2VUYWIiLCJwb3NpdGlvbiI6IkJvdHRvbVRhYkJhciIsInR5cGUiOiJkb3QiLCJ2YWx1ZSI6IjAifSx7InBvc2l0aW9uX2lkIjoiVXNlckhvbWVUYWIiLCJ0eXBlIjoiZG90IiwicG9zaXRpb24iOiJCb3R0b21UYWJCYXIiLCJ2YWx1ZSI6IjEifV1CCTE4MjY5MjkzNkoEUG9zdFIBMhKEBAoJMTgyNjkyOTM2EgNpb3MaCmlQaG9uZTE0LDMiBjE3LjMuMSokQUZBNURCRDctRDAyNy00MDJCLTk1MjItMUQ5QTRBNUVGQjg1MgYyLjY4LjE6CGFwcHN0b3JlQgwKB2dhbWVfaWQSATBC3gIKCm1oeV9hYnRlc3QSzwJbeyJ0ZXN0X25hbWUiOiI1MTY0XzM4NiIsImNvbmZpZyI6eyJpc19saXZlIjoiMSJ9LCJ2ZXJzaW9uIjoiMiJ9LHsidGVzdF9uYW1lIjoiNTM0N181ODMiLCJjb25maWciOnt9LCJ2ZXJzaW9uIjoiMiJ9LHsidGVzdF9uYW1lIjoiNTMwOF81NDIiLCJjb25maWciOnt9LCJ2ZXJzaW9uIjoiMiJ9LHsidmVyc2lvbiI6IjIiLCJjb25maWciOiIiLCJ0ZXN0X25hbWUiOiI1MTAwXzY4NyJ9LHsiY29uZmlnIjp7fSwidGVzdF9uYW1lIjoiNTI4M181MTIiLCJ2ZXJzaW9uIjoiMSJ9LHsiY29uZmlnIjp7ImVuYWJsZSI6InRydWUifSwidmVyc2lvbiI6IjIiLCJ0ZXN0X25hbWUiOiI1MjM2XzQxOCJ9XUINCghpc19uaWdodBIBMEIaCglkZXZpY2VfZnASDTM4ZDdmMzQ5ZTkzZDhCDAoHaXNfdGVlbhIBMBpkCg0xNzA4MzQ0MDU3Nzk2EAgiDTE3MDgzNDQwNTc3ODg6EAoLaGJfZHVyYXRpb24SATA6FAoKY3NtX3NvdXJjZRIGbXlzZWxmOhoKCXNlc3Npb25JRBINMTcwODM0NDA1Nzc4OA==|Cj8SIlNldHRpbmdzTW9kdWxlLkFib3V0Vmlld0NvbnRyb2xsZXIyDkhvbWVNeXNlbGZQYWdlUgkxODI2OTI5MzYShAQKCTE4MjY5MjkzNhIDaW9zGgppUGhvbmUxNCwzIgYxNy4zLjEqJEFGQTVEQkQ3LUQwMjctNDAyQi05NTIyLTFEOUE0QTVFRkI4NTIGMi42OC4xOghhcHBzdG9yZULeAgoKbWh5X2FidGVzdBLPAlt7InRlc3RfbmFtZSI6IjUxNjRfMzg2IiwiY29uZmlnIjp7ImlzX2xpdmUiOiIxIn0sInZlcnNpb24iOiIyIn0seyJ0ZXN0X25hbWUiOiI1MzQ3XzU4MyIsImNvbmZpZyI6e30sInZlcnNpb24iOiIyIn0seyJ0ZXN0X25hbWUiOiI1MzA4XzU0MiIsImNvbmZpZyI6e30sInZlcnNpb24iOiIyIn0seyJ2ZXJzaW9uIjoiMiIsImNvbmZpZyI6IiIsInRlc3RfbmFtZSI6IjUxMDBfNjg3In0seyJjb25maWciOnt9LCJ0ZXN0X25hbWUiOiI1MjgzXzUxMiIsInZlcnNpb24iOiIxIn0seyJjb25maWciOnsiZW5hYmxlIjoidHJ1ZSJ9LCJ2ZXJzaW9uIjoiMiIsInRlc3RfbmFtZSI6IjUyMzZfNDE4In1dQgwKB2lzX3RlZW4SATBCDQoIaXNfbmlnaHQSATBCGgoJZGV2aWNlX2ZwEg0zOGQ3ZjM0OWU5M2Q4QgwKB2dhbWVfaWQSATAaVQoNMTcwODM0MzEyOTAzMhADOhAKCGR1cmF0aW9uEgQ1NTE2OhQKCmNzbV9zb3VyY2USBm15c2VsZjoaCglzZXNzaW9uSUQSDTE3MDgzNDMxMjkwMzI=|Cj8SIlNldHRpbmdzTW9kdWxlLkFib3V0Vmlld0NvbnRyb2xsZXIyDkhvbWVNeXNlbGZQYWdlUgkxODI2OTI5MzYShAQKCTE4MjY5MjkzNhIDaW9zGgppUGhvbmUxNCwzIgYxNy4zLjEqJEFGQTVEQkQ3LUQwMjctNDAyQi05NTIyLTFEOUE0QTVFRkI4NTIGMi42OC4xOghhcHBzdG9yZUIMCgdnYW1lX2lkEgEwQt4CCgptaHlfYWJ0ZXN0Es8CW3sidGVzdF9uYW1lIjoiNTE2NF8zODYiLCJjb25maWciOnsiaXNfbGl2ZSI6IjEifSwidmVyc2lvbiI6IjIifSx7InRlc3RfbmFtZSI6IjUzNDdfNTgzIiwiY29uZmlnIjp7fSwidmVyc2lvbiI6IjIifSx7InRlc3RfbmFtZSI6IjUzMDhfNTQyIiwiY29uZmlnIjp7fSwidmVyc2lvbiI6IjIifSx7InZlcnNpb24iOiIyIiwiY29uZmlnIjoiIiwidGVzdF9uYW1lIjoiNTEwMF82ODcifSx7ImNvbmZpZyI6e30sInRlc3RfbmFtZSI6IjUyODNfNTEyIiwidmVyc2lvbiI6IjEifSx7ImNvbmZpZyI6eyJlbmFibGUiOiJ0cnVlIn0sInZlcnNpb24iOiIyIiwidGVzdF9uYW1lIjoiNTIzNl80MTgifV1CGgoJZGV2aWNlX2ZwEg0zOGQ3ZjM0OWU5M2Q4QgwKB2lzX3RlZW4SATBCDQoIaXNfbmlnaHQSATAaWgoNMTcwODM0NDA1Nzc5NRoGVG9nZ2xlKgxOb3RpZmljYXRpb246FAoKY3NtX3NvdXJjZRIGbXlzZWxmOhoKCXNlc3Npb25JRBINMTcwODM0NDA1Nzc4OEIBMA==|Cj8SIlNldHRpbmdzTW9kdWxlLkFib3V0Vmlld0NvbnRyb2xsZXIyDkhvbWVNeXNlbGZQYWdlUgkxODI2OTI5MzYShAQKCTE4MjY5MjkzNhIDaW9zGgppUGhvbmUxNCwzIgYxNy4zLjEqJEFGQTVEQkQ3LUQwMjctNDAyQi05NTIyLTFEOUE0QTVFRkI4NTIGMi42OC4xOghhcHBzdG9yZUIMCgdnYW1lX2lkEgEwQgwKB2lzX3RlZW4SATBCDQoIaXNfbmlnaHQSATBC3gIKCm1oeV9hYnRlc3QSzwJbeyJ0ZXN0X25hbWUiOiI1MTY0XzM4NiIsImNvbmZpZyI6eyJpc19saXZlIjoiMSJ9LCJ2ZXJzaW9uIjoiMiJ9LHsidGVzdF9uYW1lIjoiNTM0N181ODMiLCJjb25maWciOnt9LCJ2ZXJzaW9uIjoiMiJ9LHsidGVzdF9uYW1lIjoiNTMwOF81NDIiLCJjb25maWciOnt9LCJ2ZXJzaW9uIjoiMiJ9LHsidmVyc2lvbiI6IjIiLCJjb25maWciOiIiLCJ0ZXN0X25hbWUiOiI1MTAwXzY4NyJ9LHsiY29uZmlnIjp7fSwidGVzdF9uYW1lIjoiNTI4M181MTIiLCJ2ZXJzaW9uIjoiMSJ9LHsiY29uZmlnIjp7ImVuYWJsZSI6InRydWUifSwidmVyc2lvbiI6IjIiLCJ0ZXN0X25hbWUiOiI1MjM2XzQxOCJ9XUIaCglkZXZpY2VfZnASDTM4ZDdmMzQ5ZTkzZDgaQwoNMTcwODM0NDA1Nzc5NBACOhoKCXNlc3Npb25JRBINMTcwODM0NDA1Nzc4ODoUCgpjc21fc291cmNlEgZteXNlbGY=|Cj8SIlNldHRpbmdzTW9kdWxlLkFib3V0Vmlld0NvbnRyb2xsZXIyDkhvbWVNeXNlbGZQYWdlUgkxODI2OTI5MzYShAQKCTE4MjY5MjkzNhIDaW9zGgppUGhvbmUxNCwzIgYxNy4zLjEqJEFGQTVEQkQ3LUQwMjctNDAyQi05NTIyLTFEOUE0QTVFRkI4NTIGMi42OC4xOghhcHBzdG9yZUIaCglkZXZpY2VfZnASDTM4ZDdmMzQ5ZTkzZDhCDAoHaXNfdGVlbhIBMELeAgoKbWh5X2FidGVzdBLPAlt7InRlc3RfbmFtZSI6IjUxNjRfMzg2IiwiY29uZmlnIjp7ImlzX2xpdmUiOiIxIn0sInZlcnNpb24iOiIyIn0seyJ0ZXN0X25hbWUiOiI1MzQ3XzU4MyIsImNvbmZpZyI6e30sInZlcnNpb24iOiIyIn0seyJ0ZXN0X25hbWUiOiI1MzA4XzU0MiIsImNvbmZpZyI6e30sInZlcnNpb24iOiIyIn0seyJ2ZXJzaW9uIjoiMiIsImNvbmZpZyI6IiIsInRlc3RfbmFtZSI6IjUxMDBfNjg3In0seyJjb25maWciOnt9LCJ0ZXN0X25hbWUiOiI1MjgzXzUxMiIsInZlcnNpb24iOiIxIn0seyJjb25maWciOnsiZW5hYmxlIjoidHJ1ZSJ9LCJ2ZXJzaW9uIjoiMiIsInRlc3RfbmFtZSI6IjUyMzZfNDE4In1dQgwKB2dhbWVfaWQSATBCDQoIaXNfbmlnaHQSATAaVAoNMTcwODM0NDA1ODQxMBADOg8KCGR1cmF0aW9uEgM3NTU6FAoKY3NtX3NvdXJjZRIGbXlzZWxmOhoKCXNlc3Npb25JRBINMTcwODM0NDA1Nzc4OA==|CgASvwYKCTE4MjY5MjkzNhIDaW9zGgppUGhvbmUxNCwzIgYxNy4zLjEqJEFGQTVEQkQ3LUQwMjctNDAyQi05NTIyLTFEOUE0QTVFRkI4NTIGMi42OC4xOghhcHBzdG9yZUJCChdhY2Nlc3NiaWxlX3NlcnZpY2VfbGlzdBInU2hha2VUb1VuZG9FbmFibGVkLFZpZGVvQXV0b3BsYXlFbmFibGVkQhQKCnRvdGFsX3RpbWUSBjM5MzY5NEIMCgdpc190ZWVuEgEwQhMKDHZlcnNpb25fY29kZRIDNDM0QhgKEmFwcF91c2VfbG9jYWxfZGF5cxICNjJCFAoMcmVzb2x1dGlvbl95EgQyNzc4QhIKDWNoYXJnZV9zdGF0dXMSATBCEQoMcHJveHlfc3RhdHVzEgExQgwKB2lzX3Jvb3QSATBCFgoOYmF0dGVyeV9zdGF0dXMSBC0xMDBCGgoJZGV2aWNlX2ZwEg0zOGQ3ZjM0OWU5M2Q4QhgKEXNjcmVlbl9icmlnaHRuZXNzEgMwLjVCIQoPcGhvbmVfY2hpcF9pbmZvEg5DUFVfVFlQRV9BUk02NEINCghpc19uaWdodBIBMEINCgZ2b2x1bWUSAzAuNEIUCgxyZXNvbHV0aW9uX3gSBDEyODRCGQoQbW9iaWxlX29wZXJhdG9ycxIFLS0sLS1CqwIKCm1oeV9hYnRlc3QSnAJbeyJjb25maWciOnsiZW5hYmxlIjoidHJ1ZSJ9LCJ0ZXN0X25hbWUiOiI1MjM2XzQxOCIsInZlcnNpb24iOiIyIn0seyJ2ZXJzaW9uIjoiMiIsImNvbmZpZyI6e30sInRlc3RfbmFtZSI6IjUzMDhfNTQyIn0seyJ2ZXJzaW9uIjoiMiIsImNvbmZpZyI6e30sInRlc3RfbmFtZSI6IjUzNDdfNTgzIn0seyJ2ZXJzaW9uIjoiMiIsInRlc3RfbmFtZSI6IjUxNjRfMzg2IiwiY29uZmlnIjp7ImlzX2xpdmUiOiIxIn19LHsiY29uZmlnIjp7fSwidGVzdF9uYW1lIjoiNTI4M181MTIiLCJ2ZXJzaW9uIjoiMSJ9XUIRCgxuZXR3b3JrX3R5cGUSATEaSwoNMTcwODM1MDc0Njg2NBAGOgoKBGRhdGESAltdOhoKCXNlc3Npb25JRBINMTcwODM1MDc0Njg2NDoQCgtpc19jb2xkYm9vdBIBMQ=="
}
```

### 获取米游社用户的游戏记录

https://api-takumi-record.mihoyo.com/game_record/card/api/getGameRecordCard?uid=182692936

### 获取米游社Binding AuthKey

https://api-takumi.miyoushe.com/binding/api/genAuthKey

请求参数
```json
{
    "region": "cn_gf01",
    "auth_appid": "csc",
    "game_uid": 109050292,
    "game_biz": "hk4e_cn"
}
```

### 获取米游社Account AuthKey

请求参数
```json
{
    "game_biz": "bbs_cn",
    "auth_appid": "csc"
}
```

## 原神

### 获取原神实时便签

https://api-takumi-record.mihoyo.com/game_record/app/genshin/aapi/widget/v2

https://api-takumi-record.mihoyo.com/game_record/app/genshin/api/dailyNote?server=cn_gf01&role_id=109050292


### 获取原神已拥有的角色列表

https://api-takumi-record.mihoyo.com/game_record/app/genshin/api/character

请求参数
```json
{
    "role_id": "109050292",
    "server": "cn_gf01"
}
```

https://api-takumi.mihoyo.com/event/e20200928calculate/v1/sync/avatar/list

请求参数
```json
{
    "element_attr_ids": [],
    "weapon_cat_ids": [],
    "page": 1,
    "size": 20,
    "uid": "109050292",
    "region": "cn_gf01"
}
```

### 获取原神所有的角色列表

https://api-takumi.mihoyo.com/event/e20200928calculate/v1/avatar/list

> Note: 
> element_attr_ids:  元素类型id
> weapon_cat_ids: 武器类型id

请求参数
```json
{
    "element_attr_ids": [],
    "weapon_cat_ids": [],
    "page": 1,
    "size": 20,
    "is_all": true
}
```

### 获取原神所有的分类

https://api-takumi.mihoyo.com/event/e20200928calculate/v1/item/filter


### 获取原神角色的天赋信息

https://api-takumi.mihoyo.com/event/e20200928calculate/v1/avatarSkill/list?avatar_id=10000089&element_attr_id=6

> Note: 
> avatar_id:  角色id
> element_attr_id: 素类型id

### 获取原神角色养成数据

https://api-takumi.mihoyo.com/event/e20200928calculate/v2/compute

请求参数
```json
{
    "avatar_id": 10000089,
    "avatar_level_current": 1,
    "avatar_level_target": 90,
    "element_attr_id": 6,
    "skill_list": [{
        "id": 8931,
        "level_current": 1,
        "level_target": 10
    }, {
        "id": 8932,
        "level_current": 1,
        "level_target": 10
    }, {
        "id": 8939,
        "level_current": 1,
        "level_target": 10
    }, {
        "id": 8921,
        "level_current": 1,
        "level_target": 1
    }, {
        "id": 8922,
        "level_current": 1,
        "level_target": 1
    }, {
        "id": 8923,
        "level_current": 1,
        "level_target": 1
    }],
    "weapon": {},
    "reliquary_list": []
}
```


### 获取原神的深渊记录

https://api-takumi-record.mihoyo.com/game_record/app/genshin/api/spiralAbyss?schedule_type=1&role_id=109050292&server=cn_gf01


## 星穹铁道

### 获取星穹铁道已有角色
https://api-takumi-record.mihoyo.com/game_record/app/hkrpg/api/avatar/basic?rolePageAccessNotAllowed=&role_id=102731382&server=prod_gf_cn

### 获取星穹铁道角色

https://api-takumi.mihoyo.com/event/rpgcalc/avatar/list?game=hkrpg&uid=102731382&region=prod_gf_cn&lang=zh-cn&tab_from=TabAll&page=1&size=100

> Note: 
> tab_from：区分是已有角色还是全部角色，TabAll是所有，TabOwned是已有角色

### 获取星穹铁道角色当前详情信息(等级，遗器，行迹，光锥)
https://api-takumi.mihoyo.com/event/rpgcalc/avatar/detail?game=hkrpg&lang=zh-cn&item_id=1312&tab_from=TabOwned&change_target_level=0&uid=102731382&region=prod_gf_cn

### 获取星穹铁道所有的光锥
https://api-takumi.mihoyo.com/event/rpgcalc/equipment/list?game=hkrpg&uid=102731382&region=prod_gf_cn&lang=zh-cn&tab_from=TabAll&page=1&size=100

### 获取星穹铁道角色养成所消耗材料
https://api-takumi.mihoyo.com/event/rpgcalc/compute?game=hkrpg
```json
{
    "game": "hkrpg",
    "avatar": {
        "item_id": "1312",
        "cur_level": 23,
        "target_level": 80
    },
    "equipment": {
        "item_id": "21042",
        "cur_level": 1,
        "target_level": 80
    },
    "skill_list": [{
        "item_id": "1312001",
        "cur_level": 1,
        "target_level": 6
    }, {
        "item_id": "1312002",
        "cur_level": 1,
        "target_level": 10
    }, {
        "item_id": "1312003",
        "cur_level": 1,
        "target_level": 10
    }, {
        "item_id": "1312004",
        "cur_level": 1,
        "target_level": 10
    }, {
        "item_id": "1312101",
        "cur_level": 1,
        "target_level": 1
    }, {
        "item_id": "1312102",
        "cur_level": 1,
        "target_level": 1
    }, {
        "item_id": "1312103",
        "cur_level": 1,
        "target_level": 1
    }, {
        "item_id": "1312201",
        "cur_level": 1,
        "target_level": 1
    }, {
        "item_id": "1312202",
        "cur_level": 1,
        "target_level": 1
    }, {
        "item_id": "1312203",
        "cur_level": 1,
        "target_level": 1
    }, {
        "item_id": "1312204",
        "cur_level": 1,
        "target_level": 1
    }, {
        "item_id": "1312205",
        "cur_level": 1,
        "target_level": 1
    }, {
        "item_id": "1312206",
        "cur_level": 1,
        "target_level": 1
    }, {
        "item_id": "1312207",
        "cur_level": 1,
        "target_level": 1
    }, {
        "item_id": "1312208",
        "cur_level": 1,
        "target_level": 1
    }, {
        "item_id": "1312209",
        "cur_level": 1,
        "target_level": 1
    }, {
        "item_id": "1312210",
        "cur_level": 1,
        "target_level": 1
    }],
    "lang": "zh-cn",
    "uid": "102731382",
    "region": "prod_gf_cn"
}
```

### 获取星穹铁道的Widget

https://api-takumi-record.mihoyo.com/game_record/app/hkrpg/aapi/widget

https://api-takumi-record.mihoyo.com/game_record/app/hkrpg/api/note?server=prod_gf_cn&role_id=102731382

### 获取星穹铁道的模拟宇宙

https://api-takumi-record.mihoyo.com/game_record/app/hkrpg/api/rogue?role_id=102731382&server=prod_gf_cn&schedule_type=3&need_detail=true

### 获取星穹铁道混沌回忆

https://api-takumi-record.mihoyo.com/game_record/app/hkrpg/api/challenge?role_id=102731382&server=prod_gf_cn&isPrev=&type=challenge&schedule_type=1&need_all=true

> Note
> isPrev：混沌回忆是1，虚构叙事是空
> type：story是虚构叙事，challenge是混沌回忆
> schedule_type：1是本期，2是上期

## Header

|参数名|参数|
|:--:|:--:|
|Host|api-takumi.mihoyo.com|
|x-rpc-device_model|iPhone14,3|
|Cookie|stuid=182692936;stoken=v2_EZ6JDJqFF8b9dh5I5f1h5YHWd3Pxoae1Pmj8_daxDl1OFymHN9qOpsNrHZKfiTTyumOOS7suqEftRLeC-VhWTZHaaJveWlx6iZlLURFodFQn1t-tr2TUmYSlV_-tUsA=;mid=0otk3b2k90_mhy;login_ticket=dqY0SCsvLuYnuPwmjIYewsgpcCTVltR4IgOu9GGK;|
|User-Agent|Hyperion/434 CFNetwork/1492.0.1 Darwin/23.3.0|
|Referer|https://app.mihoyo.com|
|x-rpc-device_name|iPhone|
|x-rpc-csm_source|home|
|Connection|keep-alive|
|x-rpc-device_fp|38d7f349e93d8|
|x-rpc-channel|appstore|
|DS|1708393638,ZqCUC8,50144108f38a210d10b645e81a682a00|
|Accept-Language|zh-HK,zh-Hant;q=0.9|
|x-rpc-app_version|2.68.1|
|x-rpc-device_id|AFA5DBD7-D027-402B-9522-1D9A4A5EFB85|
|x-rpc-verify_key|bll8iq97cem8|
|x-rpc-client_type|1|
|Accept|*/*|
|Accept-Encoding|gzip, deflate, br|
|x-rpc-h265_supported|0|
|x-rpc-sys_version|17.3.1|

## 支持的机型，系统

https://gist.github.com/adamawolf/3048717

iPhone11,2 : iPhone XS
iPhone11,4 : iPhone XS Max
iPhone11,6 : iPhone XS Max Global
iPhone11,8 : iPhone XR
iPhone12,1 : iPhone 11
iPhone12,3 : iPhone 11 Pro
iPhone12,5 : iPhone 11 Pro Max
iPhone12,8 : iPhone SE 2nd Gen
iPhone13,1 : iPhone 12 Mini
iPhone13,2 : iPhone 12
iPhone13,3 : iPhone 12 Pro
iPhone13,4 : iPhone 12 Pro Max
iPhone14,2 : iPhone 13 Pro
iPhone14,3 : iPhone 13 Pro Max
iPhone14,4 : iPhone 13 Mini
iPhone14,5 : iPhone 13
iPhone14,6 : iPhone SE 3rd Gen
iPhone14,7 : iPhone 14
iPhone14,8 : iPhone 14 Plus
iPhone15,2 : iPhone 14 Pro
iPhone15,3 : iPhone 14 Pro Max
iPhone15,4 : iPhone 15
iPhone15,5 : iPhone 15 Plus
iPhone16,1 : iPhone 15 Pro
iPhone16,2 : iPhone 15 Pro Max

iPad5,1 : iPad mini 4 (WiFi)
iPad5,2 : 4th Gen iPad mini (WiFi+Cellular)
iPad5,3 : iPad Air 2 (WiFi)
iPad5,4 : iPad Air 2 (Cellular)
iPad6,3 : iPad Pro (9.7 inch, WiFi)
iPad6,4 : iPad Pro (9.7 inch, WiFi+LTE)
iPad6,7 : iPad Pro (12.9 inch, WiFi)
iPad6,8 : iPad Pro (12.9 inch, WiFi+LTE)
iPad6,11 : iPad (2017)
iPad6,12 : iPad (2017)
iPad7,1 : iPad Pro 2nd Gen (WiFi)
iPad7,2 : iPad Pro 2nd Gen (WiFi+Cellular)
iPad7,3 : iPad Pro 10.5-inch 2nd Gen
iPad7,4 : iPad Pro 10.5-inch 2nd Gen
iPad7,5 : iPad 6th Gen (WiFi)
iPad7,6 : iPad 6th Gen (WiFi+Cellular)
iPad7,11 : iPad 7th Gen 10.2-inch (WiFi)
iPad7,12 : iPad 7th Gen 10.2-inch (WiFi+Cellular)
iPad8,1 : iPad Pro 11 inch 3rd Gen (WiFi)
iPad8,2 : iPad Pro 11 inch 3rd Gen (1TB, WiFi)
iPad8,3 : iPad Pro 11 inch 3rd Gen (WiFi+Cellular)
iPad8,4 : iPad Pro 11 inch 3rd Gen (1TB, WiFi+Cellular)
iPad8,5 : iPad Pro 12.9 inch 3rd Gen (WiFi)
iPad8,6 : iPad Pro 12.9 inch 3rd Gen (1TB, WiFi)
iPad8,7 : iPad Pro 12.9 inch 3rd Gen (WiFi+Cellular)
iPad8,8 : iPad Pro 12.9 inch 3rd Gen (1TB, WiFi+Cellular)
iPad8,9 : iPad Pro 11 inch 4th Gen (WiFi)
iPad8,10 : iPad Pro 11 inch 4th Gen (WiFi+Cellular)
iPad8,11 : iPad Pro 12.9 inch 4th Gen (WiFi)
iPad8,12 : iPad Pro 12.9 inch 4th Gen (WiFi+Cellular)
iPad11,1 : iPad mini 5th Gen (WiFi)
iPad11,2 : iPad mini 5th Gen
iPad11,3 : iPad Air 3rd Gen (WiFi)
iPad11,4 : iPad Air 3rd Gen
iPad11,6 : iPad 8th Gen (WiFi)
iPad11,7 : iPad 8th Gen (WiFi+Cellular)
iPad12,1 : iPad 9th Gen (WiFi)
iPad12,2 : iPad 9th Gen (WiFi+Cellular)
iPad14,1 : iPad mini 6th Gen (WiFi)
iPad14,2 : iPad mini 6th Gen (WiFi+Cellular)
iPad13,1 : iPad Air 4th Gen (WiFi)
iPad13,2 : iPad Air 4th Gen (WiFi+Cellular)
iPad13,4 : iPad Pro 11 inch 5th Gen
iPad13,5 : iPad Pro 11 inch 5th Gen
iPad13,6 : iPad Pro 11 inch 5th Gen
iPad13,7 : iPad Pro 11 inch 5th Gen
iPad13,8 : iPad Pro 12.9 inch 5th Gen
iPad13,9 : iPad Pro 12.9 inch 5th Gen
iPad13,10 : iPad Pro 12.9 inch 5th Gen
iPad13,11 : iPad Pro 12.9 inch 5th Gen
iPad13,16 : iPad Air 5th Gen (WiFi)
iPad13,17 : iPad Air 5th Gen (WiFi+Cellular)
iPad13,18 : iPad 10th Gen
iPad13,19 : iPad 10th Gen
iPad14,3 : iPad Pro 11 inch 4th Gen
iPad14,4 : iPad Pro 11 inch 4th Gen
iPad14,5 : iPad Pro 12.9 inch 6th Gen
iPad14,6 : iPad Pro 12.9 inch 6th Gen

## Wiki

Honkai3
https://honkaiimpact3.fandom.com/wiki/Honkai_Impact_3_Wiki

Honkai: Star Rail
https://honkai-star-rail.fandom.com/wiki/Honkai:_Star_Rail_Wiki

Genshin Impact
https://genshin-impact.fandom.com/wiki/Genshin_Impact_Wiki


### 星穹铁道的API
Endpoint:
https://enka.network/api/hsr/uid/000000000

Structure:
https://march7th.xiaohei.moe/en/resource/mihomo_api.html

Parser example:
https://github.com/Mar-7th/mihomo.py/blob/master/mihomo/api.py

## 参考库

[gsiod_core](https://github.com/Genshin-bots/gsuid_core)
[KimigaiiWuyi/GenshinUID](https://github.com/KimigaiiWuyi/GenshinUID)
[baiqwerdvd/StarRailUID](https://github.com/baiqwerdvd/StarRailUID)
