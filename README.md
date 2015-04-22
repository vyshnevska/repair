Repair Data
=========
Script to repair corrupted return reasons

Usage:
---------
*  **Gems:**
    ```
      csv
      roo
      rspec
    ```
*  **To generate repaired csv file simply run:**
    ```
      ruby repair_data.rb
    ```
    ```
      File to repair    : 'corrupt_reasons.csv'
      Repaired csv file : 'corrupt_reasons_fixed.csv'
    ```

*  **To test simply run:**
    ```
      rspec specs/repair_data_spec.rb
      rspec specs/repair_rules_spec.rb
    ```
    ```
      Test CSV File: 'test_repair_data.csv'
    ```
