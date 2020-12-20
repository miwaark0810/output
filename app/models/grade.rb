class Grade < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '小学生' },
    { id: 3, name: '中学1年生' },
    { id: 4, name: '中学2年生' },
    { id: 5, name: '中学3年生' },
    { id: 6, name: '高校1年生' },
    { id: 7, name: '高校2年生' },
    { id: 8, name: '高校3年生' },
    { id: 9, name: '大学生' },
    { id: 10, name: '社会人' }
  ]

  include ActiveHash::Associations
  has_many :users
end