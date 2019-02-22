function dump(o)
  if type(o) == 'table' then
    local s = '{ '
    for k,v in pairs(o) do
      if type(k) ~= 'number' then k = '"'..k..'"' end
        s = s .. '['..k..'] = ' .. dump(v) .. ','
    end
    return s .. '} '
  else
    return tostring(o)
  end
end

function setup(job_desc, job_rec, part_list, uid)
  slurm.log_user("Hello World!")
  slurm.log_user(dump(job_desc))
  return slurm.SUCCESS
end

function slurm_job_submit(job_desc, part_list, submit_uid)
  slurm.log_info("slurm_job_submit")
  slurm.log_user(dump(job_desc))
  return setup(job_desc, nil, part_list, submit_uid)
end

function slurm_job_modify(job_desc, job_rec, part_list, modify_uid)
  slurm.log_info("slurm_job_modify")
  return setup(job_desc, job_rec, part_list, modify_uid)
end

return slurm.SUCCESS
