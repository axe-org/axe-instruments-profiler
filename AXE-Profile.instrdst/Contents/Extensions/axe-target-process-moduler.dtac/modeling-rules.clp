;  target-process-moduler.clp
;  AXE-Profile
;
;  Created by 罗贤明 on 2018/11/24.
;  Copyright © 2018年 罗贤明. All rights reserved.
(deftemplate MODELER::last-recorded-time
    (slot last-time (type INTEGER) (default 0))
)

;;
;; FACTS (initial conditions)
;;
(deffacts MODELER::initial-facts
    (last-recorded-time (last-time 0))
)

(defrule MODELER::found-cause
    (sysmon-process (time ?time) (process ?process) (recently-died ?recently-died) (arch-kind ?arch-kind) (sudden-termination ?sudden-termination) (sandbox ?sandbox)(restricted ?restricted) (app-nap ?app-nap) (context-switch ?context-switch) (cpu-percent ?cpu-percent) (cpu-total-system ?cpu-total-system)(cpu-total-user ?cpu-total-user) (disk-bytes-read ?disk-bytes-read) (disk-bytes-written ?disk-bytes-written) (faults ?faults) (interrupt-wakeups ?interrupt-wakeups)(mach-port-count ?mach-port-count) (memory-physical-footprint ?memory-physical-footprint) (memory-anonymous ?memory-anonymous) (memory-compressed ?memory-compressed) (memory-purgeable ?memory-purgeable)(memory-real-private ?memory-real-private) (memory-real-shared ?memory-real-shared) (memory-resident-size ?memory-resident-size) (memory-virtual-size ?memory-virtual-size) (msg-received ?msg-received)(msg-sent ?msg-sent) (pgid ?pgid) (ppid ?ppid) (pid ?pid) (proc-status ?proc-status)(responsible-pid ?responsible-pid) (sys-calls-mach ?sys-calls-mach) (sys-calls-unix ?sys-calls-unix) (thread-count ?thread-count) (uid ?uid)(vm-page-ins ?vm-page-ins) (parent-process ?parent-process) (responsible-process ?responsible-process))
;    从当前表中获取 target-pid信息。
    (table-attribute (table-id ?table) (has target-pid ?target-pid))
;    判断target-pid
    (test (= ?target-pid ?pid))
    =>
    (bind ?last-time ?time)
    (assert (axe-sysmon-process-target (time ?time) (process ?process) (recently-died ?recently-died) (arch-kind ?arch-kind) (sudden-termination ?sudden-termination) (sandbox ?sandbox)(restricted ?restricted) (app-nap ?app-nap) (context-switch ?context-switch) (cpu-percent ?cpu-percent) (cpu-total-system ?cpu-total-system)(cpu-total-user ?cpu-total-user) (disk-bytes-read ?disk-bytes-read) (disk-bytes-written ?disk-bytes-written) (faults ?faults) (interrupt-wakeups ?interrupt-wakeups)(mach-port-count ?mach-port-count) (memory-physical-footprint ?memory-physical-footprint) (memory-anonymous ?memory-anonymous) (memory-compressed ?memory-compressed) (memory-purgeable ?memory-purgeable)(memory-real-private ?memory-real-private) (memory-real-shared ?memory-real-shared) (memory-resident-size ?memory-resident-size) (memory-virtual-size ?memory-virtual-size) (msg-received ?msg-received)(msg-sent ?msg-sent) (pgid ?pgid) (ppid ?ppid) (pid ?pid) (proc-status ?proc-status)(responsible-pid ?responsible-pid) (sys-calls-mach ?sys-calls-mach) (sys-calls-unix ?sys-calls-unix) (thread-count ?thread-count) (uid ?uid)(vm-page-ins ?vm-page-ins) (parent-process ?parent-process) (responsible-process ?responsible-process)))
)



(defrule RECORDER::create-table
    ?input <- (axe-sysmon-process-target (time ?time) (process ?process) (recently-died ?recently-died) (arch-kind ?arch-kind) (sudden-termination ?sudden-termination) (sandbox ?sandbox)(restricted ?restricted) (app-nap ?app-nap) (context-switch ?context-switch) (cpu-percent ?cpu-percent) (cpu-total-system ?cpu-total-system)(cpu-total-user ?cpu-total-user) (disk-bytes-read ?disk-bytes-read) (disk-bytes-written ?disk-bytes-written) (faults ?faults) (interrupt-wakeups ?interrupt-wakeups)(mach-port-count ?mach-port-count) (memory-physical-footprint ?memory-physical-footprint) (memory-anonymous ?memory-anonymous) (memory-compressed ?memory-compressed) (memory-purgeable ?memory-purgeable)(memory-real-private ?memory-real-private) (memory-real-shared ?memory-real-shared) (memory-resident-size ?memory-resident-size) (memory-virtual-size ?memory-virtual-size) (msg-received ?msg-received)(msg-sent ?msg-sent) (pgid ?pgid) (ppid ?ppid) (pid ?pid) (proc-status ?proc-status)(responsible-pid ?responsible-pid) (sys-calls-mach ?sys-calls-mach) (sys-calls-unix ?sys-calls-unix) (thread-count ?thread-count) (uid ?uid)(vm-page-ins ?vm-page-ins) (parent-process ?parent-process) (responsible-process ?responsible-process))
    
    ?f <- (last-recorded-time (last-time ?last-time))

    (table (table-id ?t) (side append))
    
    (table-attribute (table-id ?t) (has schema axe-sysmon-process-target))
    
    =>
;    计算时间。
    (bind ?duration (- ?time ?last-time))
;    输入数据要进行清理。
    (retract ?f)
    (retract ?input)
;    记录一个新的开始时间。
    (assert (last-recorded-time (last-time ?time)))
;    输出时，要先创建一行
    (create-new-row ?t)
;    然后设置值。
    (set-column time ?last-time)
    (set-column period ?duration)
    (set-column process ?process)
    (set-column recently-died ?recently-died)
    (set-column arch-kind ?arch-kind)
    (set-column sudden-termination ?sudden-termination)
    (set-column sandbox ?sandbox)
    (set-column restricted ?restricted)
    (set-column app-nap ?app-nap)
    (set-column context-switch ?context-switch)
    (set-column cpu-percent ?cpu-percent)
    (set-column cpu-total-system ?cpu-total-system)
    (set-column cpu-total-user ?cpu-total-user)
    (set-column disk-bytes-read ?disk-bytes-read)
    (set-column disk-bytes-written ?disk-bytes-written)
    (set-column faults ?faults)
    (set-column interrupt-wakeups ?interrupt-wakeups)
    (set-column mach-port-count ?mach-port-count)
    (set-column memory-physical-footprint ?memory-physical-footprint)
    (set-column memory-anonymous ?memory-anonymous)
    (set-column memory-compressed ?memory-compressed)
    (set-column memory-purgeable ?memory-purgeable)
    (set-column memory-real-private ?memory-real-private)
    (set-column memory-real-shared ?memory-real-shared)
    (set-column memory-resident-size ?memory-resident-size)
    (set-column memory-virtual-size ?memory-virtual-size)
    (set-column msg-received ?msg-received)
    (set-column msg-sent ?msg-sent)
    (set-column pgid ?pgid)
    (set-column ppid ?ppid)
    (set-column pid ?pid)
    (set-column proc-status ?proc-status)
    (set-column responsible-pid ?responsible-pid)
    (set-column sys-calls-mach ?sys-calls-mach)
    (set-column sys-calls-unix ?sys-calls-unix)
    (set-column thread-count ?thread-count)
    (set-column uid ?uid)
    (set-column vm-page-ins ?vm-page-ins)
    (set-column parent-process ?parent-process)
    (set-column responsible-process ?responsible-process)
)
