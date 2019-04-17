
function setup(job_desc, job_rec, part_list, uid, logger)
  logger("Hello World!")
--  logger(job_desc.partition)
  return slurm.SUCCESS
end

function slurm_job_submit(job_desc, part_list, submit_uid)
  slurm.log_user("slurm_job_submit")
  return setup(job_desc, nil, part_list, submit_uid, slurm.log_user)
end

function slurm_job_modify(job_desc, job_rec, part_list, modify_uid)
  slurm.log_info("slurm_job_modify")
--  slurm.log_info(job_desc.partition)
--  slurm.log_info(job_rec.partition)

  if modify_uid ~= 0 then
    if job_desc.partition and job_rec.partition then
      if job_desc.partition ~= job_rec.partition then
        slurm.log_error("UID " .. modify_uid .. " is attempting to change from partition \"" .. job_rec.partition .. "\" to \"" .. job_desc.partition .. "\" ... operation not permitted.")
        job_desc.partition = job_rec.partition
        return slurm.ESLURM_ACCESS_DENIED
      end
    end
  end

  return setup(job_desc, job_rec, part_list, modify_uid, slurm.log_info)
end

return slurm.SUCCESS
