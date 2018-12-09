describe Hash do
  describe '#camelize_keys!' do
    let(:underscored_hash) do
      {
        abcd_efgh_1234_ijkl_mnop: 'テスト',
        abcdEfgh_5678_ijklMnop: 'テスト',
        abcdEfgh_1234: 'テスト',
        '1234_abcdEfgh_1234' => { abcd_efgh_9012_ijkl_mnop: 'テスト' }
      }
    end

    let(:camelized_hash) do
      {
        abcdEfgh_1234_ijklMnop: 'テスト',
        abcdEfgh_5678_ijklMnop: 'テスト',
        abcdEfgh_1234: 'テスト',
        :'1234_abcdEfgh_1234' => { abcdEfgh_9012_ijklMnop: 'テスト' }
      }
    end

    subject { underscored_hash.camelize_keys! }
    it { is_expected.to eq camelized_hash }
  end
end
