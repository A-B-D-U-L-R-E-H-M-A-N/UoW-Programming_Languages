fun is_older(date1 : int*int*int, date2: int*int*int) =
    if (#1 date2 > #1 date1) 
    then true
    else if (#1 date2 >= #1 date1) andalso (#2 date2 > #2 date1)
    then true
    else if ((#1 date2 >= #1 date1) andalso (#2 date2 >= #2 date1) andalso (#3 date2 > #3 date1))
    then true
    else false;
    
    
fun number_in_month(date_list : (int*int*int) list, month: int) =
    if null date_list
    then 0
    else if #2 (hd date_list) = month
    then 1 + number_in_month(tl date_list, month)
    else 0 + number_in_month(tl date_list, month)
    
    
fun number_in_months(date_list: (int*int*int) list, month_list: int list) =
    if (null month_list) orelse (null date_list)
    then 0
    else number_in_month(date_list, hd month_list) + number_in_months(date_list, tl month_list)
    
fun dates_in_month(date_list: (int*int*int) list, month: int) =
    if null date_list
    then []
    else if #2 (hd date_list) = month
    then hd date_list :: dates_in_month(tl date_list, month)
    else dates_in_month(tl date_list, month)
    
fun dates_in_months(date_list: (int*int*int) list,month_list: int list) =
    if (null date_list) orelse (null month_list)
    then []
    else dates_in_month(date_list, hd month_list) @ dates_in_months(date_list, tl month_list)
    
fun get_nth(string_list: string list, nth: int) =
    if nth = 1
    then hd string_list
    else get_nth(tl string_list, nth-1)
    
fun date_to_string(date: int*int*int) =
    let
    val Month_Names = ["January", "February", "March", "April","May","June", "July", "August", "September", "October", "November","December"]
    in
    get_nth(Month_Names, #2 date) ^ " " ^ Int.toString(#3 date) ^ ", " ^ Int.toString(#1 date)
    end;
    
    
fun number_before_reaching_sum(sum: int, mylist: int list) =
    if sum - (hd mylist) <= 0
    then 0
    else 1 + number_before_reaching_sum(sum - hd mylist, tl mylist)
    
fun what_month(dayofYear: int) =
    let
    val day_list = [31,29,31,30,31,30,31,30,31,30,31,30]
    in
    number_before_reaching_sum(dayofYear,day_list) + 1
    end;
    
fun month_range(day1 : int, day2: int) =
    if day1 > day2
    then []
    else what_month(day1) :: month_range(day1 + 1, day2)
    
fun oldest(date_list : (int*int*int) list) = 
    if null date_list
    then NONE
    else let fun oldest_in_list(myList: (int*int*int) list) = 
    if null (tl myList)
    then hd myList
    else let val older = oldest_in_list(tl myList)
    in
    if is_older(hd myList, older)
    then hd myList
    else older
    end
    in
        SOME(oldest_in_list(date_list))
    end
    
val test1 = is_older ((1,2,3),(1,2,4)) = true;
val test2 = number_in_month ([(2012,2,28),(2013,12,1),(2011,2,13)],2) = 2
val test3 = number_in_months ([(2012,3,28),(2013,12,1),(2011,3,31),(2011,4,28),(2013,4,4)],[2,3,4]) = 4;
val test4 = dates_in_month ([(2012,2,28),(2013,12,1),(2016,2,28)],2) = [(2012,2,28),(2016,2,28)];

val test5 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28),(2011,5,28)],[2,3,4,5]) = [(2012,2,28),(2011,3,31),(2011,4,28),(2011,5,28)]
val test6 = get_nth (["hi", "there", "how", "are", "you"], 1) = "hi";
val test7 = date_to_string (2013, 6, 1) = "June 1, 2013";
val test8 = number_before_reaching_sum (60, [31,29,30])=1;
val test9 = what_month 70 = 3

val test10 = month_range (31, 35)= [1,2,2,2,2]

val test11 = oldest([(2012,2,28),(2011,3,31),(2011,4,28),(2009,3,21)]) = SOME (2009,3,21)