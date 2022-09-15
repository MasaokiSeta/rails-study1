class TaskMailer < ApplicationMailer
  def creation_email(task)
    @task = task
    mail(
      subject: "タスク作成完了メール",
      to: "user@example.com",
      from: "taskmemo@example.com",
    )
  end
end
