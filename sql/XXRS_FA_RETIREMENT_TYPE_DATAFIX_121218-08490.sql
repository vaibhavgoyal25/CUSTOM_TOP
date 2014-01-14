/***************************************************************************************************
* NAME : XXRS_FA_RETIREMENT_TYPE_DATAFIX_121218-08490.sql                                          *
* DESCRIPTION :                                                                                    *
* Datafix to update retirement Type Code.                                                          *
*                                                                                                  *
* AUTHOR       : Vaibhav Goyal                                                                     *
* DATE WRITTEN : 19-DEC-2012                                                                       *
*                                                                                                  *
* CHANGE CONTROL :                                                                                 *
* Version# | Ticket #     |  WHO            | DATE        |   REMARKS                              *
*--------------------------------------------------------------------------------------------------*
* 1.0.0    | 121218-08490 | Vaibhav Goyal   | 19-DEC-2012 | Initial Creation                       *
****************************************************************************************************/
--  /* $Header: XXRS_FA_RETIREMENT_TYPE_DATAFIX_121218-08490.sql 1.0.0 19-DEC-2012 13:23:00 Vaibhav Goyal $ */

SET SERVEROUTPUT ON SIZE 1000000;

col file_name   new_value   spool_file_name    noprint
SELECT 'XXRS_FA_RET_TYPE_UPD_121218-08490'||to_char (sysdate, '_mmddyy_hhmiss')||'.log' file_name from dual;
SPOOL &spool_file_name;

DECLARE
   CURSOR cur_ret_id (p_book_type_code IN VARCHAR2)
    IS
      SELECT fad.asset_number
           , far.retirement_id
           , far.asset_id
           , far.retirement_type_code
           , fad.serial_number
           , far.book_type_code
           , far.date_retired
        FROM fa.fa_retirements  far
           , fa_additions fad
       WHERE 1=1 --
         AND far.asset_id=fad.asset_id
         AND far.book_type_code = p_book_type_code
         AND far.retirement_type_code = 'Sub-Assembly';
--
    l_procedure_name     VARCHAR2(50);
    l_serial_number      VARCHAR2(600);
    l_reason_name        VARCHAR2(600);
    l_return_status      VARCHAR2 (1);
    l_api_data           VARCHAR2 (2000) := NULL;
    l_api_msg_indexout   NUMBER := NULL;
    l_api_error          VARCHAR2 (2000) := NULL;
    l_msg_data           VARCHAR2 (1000);
    l_asst_ret_rec       fa_api_types.asset_retire_rec_type;
    l_asst_hdr_rec       fa_api_types.asset_hdr_rec_type;
    l_trans_rec          fa_api_types.trans_rec_type;
    l_msg_count          NUMBER;
    l_succ_count         NUMBER;
    l_tot_count          NUMBER;
    l_err_count          NUMBER;
    l_book_type_code     VARCHAR2(30);
--
BEGIN
  l_procedure_name := 'UPDATE_RETIREMENT_TYPE';
  l_succ_count:=0;
  l_tot_count:=0;
  l_err_count:=0;
  l_book_type_code := 'RS US FA CORP';
--
  FOR rec_ret_id in cur_ret_id (l_book_type_code)
  LOOP
    BEGIN
      l_serial_number := rec_ret_id.serial_number;
      l_reason_name := 'SUB-ASSEMBLY';

      IF l_reason_name IS NOT NULL AND NVL(l_reason_name,'#') <> NVL(rec_ret_id.retirement_type_code,'#') 
      THEN
        BEGIN
          l_asst_ret_rec.retirement_id := rec_ret_id.retirement_id;
          l_asst_ret_rec.retirement_type_code :=l_reason_name;
          l_asst_ret_rec.retirement_id := rec_ret_id.retirement_id;

          --calling API to update retirement details
          fa_asset_desc_pub.update_retirement_desc( p_api_version                => 1.0
                                                  , p_init_msg_list              => fnd_api.g_true
                                                  , p_commit                     => fnd_api.g_true
                                                  , p_validation_level           => fnd_api.g_valid_level_full
                                                  , x_return_status              => l_return_status
                                                  , x_msg_count                  => l_msg_count
                                                  , x_msg_data                   => l_msg_data
                                                  , p_calling_fn                 => NULL
                                                  , px_trans_rec                 => l_trans_rec
                                                  , px_asset_hdr_rec             => l_asst_hdr_rec
                                                  , px_asset_retire_rec_new      => l_asst_ret_rec
                                                  );
          
          IF l_return_status <> 'S' 
          THEN
            FOR i IN 1 .. l_msg_count
            LOOP
              fnd_msg_pub.get (i, 'F', l_api_data, l_api_msg_indexout);
              l_api_error := l_api_error || ';' || l_api_data;
            END LOOP;
            DBMS_OUTPUT.PUT_LINE('l_api_error: ' || l_api_error);
            DBMS_OUTPUT.PUT_LINE('asset_id: ' || rec_ret_id.asset_id);
            DBMS_OUTPUT.PUT_LINE('book_type_code: ' || rec_ret_id.book_type_code);
          ELSE
            DBMS_OUTPUT.PUT_LINE('asset_id: ' || rec_ret_id.asset_id);
            DBMS_OUTPUT.PUT_LINE('book_type_code: ' || rec_ret_id.book_type_code);
            DBMS_OUTPUT.PUT_LINE('Retirement type: ' || rec_ret_id.RETIREMENT_TYPE_CODE ||' => '|| l_reason_name );
          END IF;
        EXCEPTION
          WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Unexepected error while updating asset_id: '||rec_ret_id.asset_id);
            DBMS_OUTPUT.PUT_LINE(sqlerrm);
        END;
--
      ELSE
        DBMS_OUTPUT.PUT_LINE('No need for update: ');
        DBMS_OUTPUT.PUT_LINE('asset_id: ' || rec_ret_id.asset_id);
        DBMS_OUTPUT.PUT_LINE('book_type_code: ' || rec_ret_id.book_type_code);
      END IF;
    
    EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Unexepected error while processing asset_id: '||rec_ret_id.asset_id);
      DBMS_OUTPUT.PUT_LINE(sqlerrm);
    END;
  END LOOP;
--
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Unexepected error:');
    DBMS_OUTPUT.PUT_LINE(sqlerrm);
END;
/

SPOOL OFF;