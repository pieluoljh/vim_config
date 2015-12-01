XPTemplate priorit=personal

XPT copyright
Copyright (C) 2014 Sony Mobile Communications Inc.

XPT printk synonym=pk	" printk\(...)
printk(`$SParg^`KERN_^`:_printfElts:^`$SParg^)

XPT early_printk " early_printk\(...)
early_printk(`$SParg^`:_printfElts:^`$SParg^)

XPT printk_sched " printk_sched\(...)
printk_sched(`$SParg^`:_printfElts:^`$SParg^)


XPT panic	" panic\(...)
panic(`$SParg^`:_printfElts:^`$SParg^)

XPT WARN	" WARN\(condition, ...)
WARN(`$SParg^`condition^,`$SPop^`:_printfElts:^`$SParg^)

XPT dev_emerg " dev_emerg\(dev, ...)
dev_emerg(`$SParg^`dev^,`$SPop^`:_printfElts:^`$SParg^)

XPT dev_alert " dev_alert\(dev, ...)
dev_alert(`$SParg^`dev^,`$SPop^`:_printfElts:^`$SParg^)

XPT dev_crit " dev_crit\(dev, ...)
dev_crit(`$SParg^`dev^,`$SPop^`:_printfElts:^`$SParg^)

XPT dev_err " dev_err\(dev, ...)
dev_err(`$SParg^`dev^,`$SPop^`:_printfElts:^`$SParg^)

XPT dev_warn " dev_warn\(dev, ...)
dev_warn(`$SParg^`dev^,`$SPop^`:_printfElts:^`$SParg^)

XPT dev_notice " dev_notice\(dev, ...)
dev_notice(`$SParg^`dev^,`$SPop^`:_printfElts:^`$SParg^)

XPT dev_info synonym=di " dev_info\(dev, ...)
dev_info(`$SParg^`dev^,`$SPop^`:_printfElts:^`$SParg^)

XPT dev_dbg synonym=dd " dev_dbg\(dev, ...)
dev_dbg(`$SParg^`dev^,`$SPop^`:_printfElts:^`$SParg^)

XPT dev_vdbg synonym=dv " dev_vdbg\(dev, ...)
dev_vdbg(`$SParg^`dev^,`$SPop^`:_printfElts:^`$SParg^)

XPT dev_WARN " dev_WARN\(dev, ...)
dev_WARN(`$SParg^`dev^,`$SPop^`:_printfElts:^`$SParg^)

XPT dev_WARN_ONCE " dev_WARN_ONCE\(dev, condition, ...)
dev_WARN_ONCE(`$SParg^`dev^,`$SPop^`condition^,`$SPop^`:_printfElts:^`$SParg^)

XPT dynamic_pr_debug " dynamic_pr_debug\(...)
dynamic_pr_debug(`$SPop^`:_printfElts:^`$SParg^)

XPT dynamic_dev_dbg " dynamic_dev_dbg\(dev, ...)
dynamic_dev_dbg(`$SParg^`dev^,`$SPop^`:_printfElts:^`$SParg^)

XPT dynamic_netdev_dbg " dynamic_netdev_dbg\(net_dev, ...)
dynamic_netdev_dbg(`$SParg^`net_dev^,`$SPop^`:_printfElts:^`$SParg^)

XPT seq_printf " seq_printf\(seq_file, ...)
seq_printf(`$SParg^`seq_file^,`$SPop^`:_printfElts:^`$SParg^)

XPT trace_seq_printf " trace_seq_printf\(trace_seq, ...)
trace_seq_printf(`$SParg^`trace_seq^,`$SPop^`:_printfElts:^`$SParg^)

XPT pr_emerg
pr_emerg(`$SParg^`:_printfElts:^`$SParg^)

XPT pr_alert
pr_alert(`$SParg^`:_printfElts:^`$SParg^)

XPT pr_crit
pr_crit(`$SParg^`:_printfElts:^`$SParg^)

XPT pr_err
pr_err(`$SParg^`:_printfElts:^`$SParg^)

XPT pr_warning
pr_warning(`$SParg^`:_printfElts:^`$SParg^)

XPT pr_warn
pr_warn(`$SParg^`:_printfElts:^`$SParg^)

XPT pr_notice
pr_notice(`$SParg^`:_printfElts:^`$SParg^)

XPT pr_info
pr_info(`$SParg^`:_printfElts:^`$SParg^)

XPT pr_cont
pr_cont(`$SParg^`:_printfElts:^`$SParg^)

XPT pr_devel
pr_devel(`$SParg^`:_printfElts:^`$SParg^)


XPT kmalloc " kmalloc\(size, flags)
kmalloc(`$SParg^`size^,`$SPop^`flags^`$SParg^)

XPT kzalloc " kzalloc\(size, flags)
kzalloc(`$SParg^`size^,`$SPop^`flags^`$SParg^)

XPT kfree " kfree\(ptr)
kfree(`$SParg`ptr^`$SParg^)

XPT vmalloc " vmalloc\(size)
vmalloc(`$SParg^`size^`$SParg^)

XPT vzalloc " vzalloc\(size)
vzalloc(`$SParg^`size^`$SParg^)

XPT vfree " vfree\(ptr)
vfree(`$SParg`ptr^`$SParg^)

XPT kvfree " kvfree\(ptr)
kvfree(`$SParg`ptr^`$SParg^)

XPT malloc " malloc\(size)
malloc(`$SParg^`size^`$SParg^)

XPT free " free\(ptr)
free(`$SParg`ptr^`$SParg^)

XPT calloc " calloc\(n, size)
calloc(`$SParg^`n^,`$SPop^`size^`$SParg^)

XPT realloc " realloc\(mem_address, new_size)
realloc(`$SParg^`mem_address^,`$SPop^`new_size^`$SParg^)

XPT memset " memset\(ptr, ch, n)
memset(`$SParg^`ptr^,`$SPop^`ch^,`$SPop^`n^`$SParg^)

XPT memcpy " memcpy\(dest, src, n)
memcpy(`$SParg^`dest^,`$SPop^`src^,`$SPop^`n^`$SParg^)

XPT memmove " memmove\(dest, src, count)
memmove(`$SParg^`dest^,`$SPop^`src^,`$SPop^`count^`$SParg^)

XPT memchr " memchr\(buf, ch, count)
memchr(`$SParg^`buf^,`$SPop^`ch^,`$SPop^`count^`$SParg^)

XPT memcmp " memcmp\(buf1, buf2, count)
memcmp(`$SParg^`buf1^,`$SPop^`buf2^,`$SPop^`count^`$SParg^)

XPT _case wrap hidden	" case ..:
case `constant^:
    `cursor^
    break;

XPT case wrap	" case ..:
`:_case:^`
`case...{{^
`Include:_case^`
`case...^`}}^

XPT main hint=main\ (argc,\ argv)
int main(`$SParg^int argc,`$SPop^char **argv`$SParg^)`$BRfun^{
    `cursor^
    return 0;
}

XPT fun wrap	hint=func..\ (\ ..\ )\ {...
`int^ `name^(`$SParg`param?`$SParg^)`$BRfun^{
    `cursor^
}

XPT ife		" if (..) {..} else ...
`:_if:^`$BRel^`:else:^
