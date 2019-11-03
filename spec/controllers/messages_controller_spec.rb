require 'rails_helper'

describe MessagesController do
  describe "Get #index" do
    let(:user) { create(:user) }
    let(:group) { create(:group) }

    context "ログインしていない場合" do
      it "意図したビューにリダイレクトできているか" do
        get :index, params: {group_id: group.id}
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログインしている場合" do
      before do
        login user
      end

      it "該当するビューが描画されているか" do
        get :index, params: {group_id: group.id}
        expect(response).to render_template :index
      end

      describe "アクション内で定義しているインスタンス変数があるか" do
        let(:groups) do
          groups = create_list(:group, 3)
          groups.each do |g|
            g.users << user
          end
          groups
        end
        let(:messages) { create_list(:message, 3, group: group) }

        before do
          get :index, params: {group_id: group.id}
        end

        it "@groupsがあるか" do
          expect(assigns(:groups)).to match groups
        end

        it "@groupがあるか" do
          expect(assigns(:group)).to match group
        end

        it "@messagesがあるか" do
          expect(assigns(:messages)).to match messages
        end

        it "@messageがあるか" do
          expect(assigns(:message)).to be_a_new Message
        end
      end
    end
  end

  describe "Post #create" do
    let(:user) { create(:user) }
    let(:group) { create(:group) }
    let(:message) { build(:message) }

    let(:params) {
      {
        group_id: group.id,
        message: {
          content: message.content,
          image: message.image,
          group_id: group.id,
          user_id: user.id
        }
      }
    }

    subject do
      post :create, params: params
    end

    context "ログインしている場合" do
      before do
        login user
      end

      context "メッセージがある場合" do
        it "投稿したら#indexにリダイレクトする" do
          expect(subject).to redirect_to group_messages_path(group.id)
        end

        it "投稿したメッセージがテーブルに保存されている" do
          subject
          message_from_table = Message.where(group_id: group.id, user_id: user.id).last
          expect(message_from_table[:content]).to eq message[:content]
        end
      end

      context "メッセージがない場合" do
        before do
          params[:message][:content] = ""
        end

        it "indexテンプレートが描画される" do
        expect(subject).to render_template :index
        end

        it "テーブルにメッセージが保存されない" do
          subject
          message_from_table = Message.all
          expect(message_from_table).to eq []
        end
      end
    end

    context "ログインしていない場合" do
      it "ログイン画面にリダイレクトする" do
        expect(subject).to redirect_to new_user_session_path
      end
    end
  end
end
