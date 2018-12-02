;  target-process-moduler.clp
;  AXE-Profile
;
;  Created by 罗贤明 on 2018/11/24.
;  Copyright © 2018年 罗贤明. All rights reserved.


(defrule RECORDER::create-table
    ?input <- (network-connection-stat (start-time ?start-time) (duration ?duration) (connection-serial ?connection-serial) (process ?process) (interface ?interface) (protocol ?protocol) (local-address ?local-address) (remote-address ?remote-address) (description ?description) (rx-packets ?rx-packets) (rx-bytes ?rx-bytes) (tx-packets ?tx-packets) (tx-bytes ?tx-bytes) (rx-dups ?rx-dups) (rx-ooo ?rx-ooo) (tx-retx ?tx-retx) (min-rtt ?min-rtt) (average-rtt ?average-rtt) )
    
;    (bind ?pid (pid-from-process ?process))
;    从当前表中获取 target-pid信息。
    (table-attribute (table-id ?table) (has target-pid ?target-pid))
;    判断target-pid
    (test (= ?target-pid (pid-from-process ?process)))
    
    (table (table-id ?t) (side append))
    
    (table-attribute (table-id ?t) (has schema axe-network-connection-stat))
    =>
    (retract ?input)
    ;    输出时，要先创建一行
    (create-new-row ?t)
    ;    然后设置值。
    (set-column start-time ?start-time)
    (set-column duration ?duration)
    (set-column connection-serial ?connection-serial)
    (set-column process ?process)
    (set-column interface ?interface)
    (set-column protocol ?protocol)
    (set-column local-address ?local-address)
    (set-column remote-address ?remote-address)
    (set-column description ?description)
    (set-column rx-packets ?rx-packets)
    (set-column rx-bytes ?rx-bytes)
    (set-column tx-packets ?tx-packets)
    (set-column tx-bytes ?tx-bytes)
    (set-column rx-dups ?rx-dups)
    (set-column rx-ooo ?rx-ooo)
    (set-column tx-retx ?tx-retx)
    (set-column min-rtt ?min-rtt)
    (set-column average-rtt ?average-rtt)
)

