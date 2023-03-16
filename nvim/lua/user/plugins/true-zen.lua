local status, true-zen = pcall(require, "true-zen")
if not status then
  return
end

true-zen.setup { }
